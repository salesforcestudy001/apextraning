/**
 *File Name     : JobApplicationTriggerHandler
 *@description  : JobApplicationトリガハンドラー
 *Author        : zongkui.yang
 *CreatedDate   : 2021/9/9
 *UpdatedDate   :
 */
public with sharing class JobApplicationTriggerHandler extends TriggerHandlerAdapter {
    /**
     *  @description 挿入前処理
     *  @param newItems
     */
    public override void beforeInsert(List<SObject> newItems) {
        Integer loopNum = 0;
        // 最大申請番号を取得
        String applicationBango = (String)[SELECT max(ApplicationBango__c)maxbango FROM Job_Application__c][0].get('maxbango');
        for(Job_Application__c app : (List<Job_Application__c>)newItems){
            loopNum = ++loopNum;
            // 申請番号を設定
            app.ApplicationBango__c = getBango(applicationBango, loopNum); 
        }
    }

    /**
     *  @description 挿入後処理
     *  @param newItems
     */
    public override void afterInsert(Map<Id, SObject> newItems) {
        //平均希望給料更新
        updateAverageSalary((Map<Id, Job_Application__c>)newItems);
    }

    /**
     *  @description 更新後処理
     *  @param newItems
     *  @param oldItems
     */
    public override void afterUpdate(Map<Id, SObject> newItems,Map<Id, SObject> oldItems) {
        //平均希望給料更新
        updateAverageSalary((Map<Id, Job_Application__c>)newItems);
        
    }

    /**
     *  @description 削除後処理
     *  @param oldItems SObjectのマップ(削除前)
     */
    public override void afterDelete(Map<Id, SObject> oldItems) {
        //平均希望給料更新
        updateAverageSalary((Map<Id, Job_Application__c>)oldItems);
    }

    /**
     *  @description 申請番号作成
     *  @param loopNum Loop回数
     */
    public String getBango(String applicationBango, Integer loopNum){
        // 新番号を設定
        Integer bango = 0;
        if(applicationBango == null || applicationBango.length() == 0){
            bango = 1;
        }else{
            applicationBango = applicationBango.substring(1);
            bango = Integer.valueOf(applicationBango) + loopNum;
        }
        String applicationBangoNew = String.valueOf(bango);
        Integer maxNum = 8-applicationBangoNew.length();
        for(Integer i=0;i<maxNum;i++){
            applicationBangoNew = '0' + applicationBangoNew;
        }
        applicationBangoNew = 'A' + applicationBangoNew;
        return applicationBangoNew;
    }
    /**
     *  @description 平均希望給料更新
     *  
     */
    public void updateAverageSalary(Map<Id, Job_Application__c> newItems){
        // mapkeyを取得
        Set<id> listMapId = newItems.keySet();
        // 変数candidateIdListを作成
        Set<id> candidateIdList = new Set<id>();
        for(id mapid : listMapId){
            // 追加したJob_Application__cに対して、関連Candidate__cのIDを取得
            candidateIdList.add(newItems.get(mapid).Candidate__c);
        }
        // 平均給料を取得
        AggregateResult[] groupedResults = [SELECT Candidate__c,AVG(ExpectSalary__c)aver FROM Job_Application__c 
            where Candidate__c in : candidateIdList group by Candidate__c];
        // 今回変更があるCandidate__cを取得する
        List<Candidate__c> candidates =[select id,AverageSalary__c from Candidate__c where id in :candidateIdList];
        // Candidate__cに平均給料を設定する
        for(Integer i=0;i<groupedResults.size();i++){
            for(Candidate__c candidate : candidates){
                if(groupedResults[i].get('Candidate__c') == candidate.id){
                    candidate.AverageSalary__c = (Decimal)groupedResults[i].get('aver');
                }
            }
        }
        // 更新を実行する
        update candidates;
    }
}