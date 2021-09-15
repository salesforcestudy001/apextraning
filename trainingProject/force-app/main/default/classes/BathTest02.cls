public with sharing class BathTest02 implements Database.Batchable<sObject>,Database.Stateful{
   

    // 实现如下batch。检索所有position,当满足postion申请的candidate人数超过10个人的时候，
    // 将发布该postion的网站在finish里打印出来。batch size设置为1。

    List<ID> positions = new List<ID>();

    public Database.QueryLocator start(Database.BatchableContext bc){
        String sql = 
            'select position__r.id from Job_Application__c ';
        return Database.getQueryLocator(sql);
    } 

    public void execute(Database.BatchableContext bc,List<Job_Application__c> records){
        for (Aggregateresult id_count :  [select position__r.id ,count(Candidate__r.id) countCan from Job_Application__c group by Position__r.id]) {
            if((Integer)id_count.get('countCan') > 10){
                positions.add((ID)id_count.get('id')); 
            }
        }
    }

    public void finish(Database.BatchableContext bc){
        List<Job_Posting__c> jps = 
            [select Position__r.id,Employment_Website__r.Web_Address__c from Job_Posting__c];
        for (ID p : positions) {
            for (Job_Posting__c jp : jps) {
                if(jp.position__r.id.equals(p)){
                    System.debug(jp.Employment_Website__r.Web_Address__c);
                }
            }
        }
    }
}
