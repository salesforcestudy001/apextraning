public with sharing class jobApplicationTriggerHandler extends TriggerHandlerAdapter {
    // ブランド店舗トリガ無効化フラグ
    public static Boolean triggerDisabled = true;
    /**
     *  @description ブランド店舗トリガ無効化フラグを取得
     *  @return triggerDisabled
     */
    public override Boolean isDisabled() {
      return triggerDisabled;
    }
    public override void beforeInsert(List<SObject> newItems) {
        //生成番号
        setBango((List<JOB_aPPLICATION__C>)newItems);

    }
    public override void afterInsert(Map<Id, SObject> newItems) {
        //求平均值
        setAverageSalary((Map<id,JOB_aPPLICATION__C>)newItems);
    }
    public override void afterUpdate(
      Map<Id, SObject> newItems,
      Map<Id, SObject> oldItems
    ) {
        //求平均值
        setAverageSalary((Map<id,JOB_aPPLICATION__C>)newItems);
    }
    public override void afterDelete(Map<Id, SObject> oldItems) {
        //求平均值
        setAverageSalary((Map<id,JOB_aPPLICATION__C>)oldItems);
    }   
    private void setBango(List<JOB_APPLICATION__C> newItems){
        List<Integer> begonlist=new List<Integer>();
        for (List<job_application__c> jobslist : [select ApplicationBango_c__c from job_application__c] ) {
            for ( job_application__c jobs : jobslist) {
                Integer begon=Integer.valueOf(jobs.ApplicationBango_c__c.subString(1,9));
                begonlist.add(begon);
            }
        }
        begonlist.sort();
        Integer Max=begonlist[begonlist.size()-1];
        for(Integer i=0;i<newItems.size();i++){
            string strbango=String.valueOf(Max+i+1);
            newItems[i].ApplicationBango_c__c='A'+strbango.leftPad(8, '0');
        }
    }
    private void setAverageSalary(map<id,job_application__c> joblst){
        set<candidate__c> canlist=new set<candidate__c>();
        map<id,candidate__c> candidates=new map<id,candidate__c>([select id from candidate__c]);
        for (AggregateResult result : [select avg(ExpectSalary_c__c)avgsalary,candidate__c from job_application__c GROUP BY candidate__c]){
            for(id jobid:joblst.keyset()){
                if ((id)result.get('candidate__c')==joblst.get(jobid).candidate__c){
                    if (joblst.get(jobid).candidate__c!=null) {
                        candidates.get(joblst.get(jobid).candidate__c).AverageSalary_c__c=(Double)result.get('avgsalary');
                        canlist.add(candidates.get(joblst.get(jobid).candidate__c));
                    }
                }
            }
        }
        list<candidate__c> CANDI=new list<candidate__c>(canlist);
        update CANDI;
        
    }
}
