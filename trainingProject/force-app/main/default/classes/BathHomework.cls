//给大家留一个作业，实现如下batch:
//检索所有position,当满足postion申请的candidate人数超过10个人的时候，
//将发布该postion的网站在finish里打印出来。(batch size设置为1。//Batch_size=1)
public with sharing class BathHomework implements Database.Batchable<sObject>,Database.stateful {
 
    Set<ID> PositionIDs = new Set<ID>();
    Set<String> Urls = new Set<String>();
 
    public Database.QueryLocator start(Database.BatchableContext bc){
        string sql = 
            'select Candidate__r.id , Position__r.id from Job_application__c where  Position__c != null and Candidate__c != null order by Position__c';
        return Database.getQueryLocator(sql);
    }
 
        public void execute(Database.BatchableContext bc,List<Job_application__c> records){
            for (Job_application__c ja : records) {
                PositionIDs.add(ja.Position__r.id);
            }
            // System.debug(PositionIDs);
            for (ID pid : PositionIDs) {
                Set<ID> CanIDs = new Set<ID>();
                for (Job_application__c ja : records) {
                    // System.debug(pid);
                    // System.debug(ja.Position__r.id);
                    if(ja.Position__r.id.equals(pid)){
                        CanIDs.add(ja.Candidate__r.id);
                    }
                }
                // System.debug(canIds.size());
                if (canIds.size() <= 1) {
                    PositionIDs.remove(pid);
                }
            }
            System.debug(PositionIDs);
        }
 
        public void finish(Database.BatchableContext bc){
           
            List<Job_posting__C> jps = [select Position__r.id,Employment_Website__r.Web_Address__c from Job_posting__C];
            for (Job_posting__C jp : jps) {
               for (Id pid02 : PositionIDs) {
                   if (jp.Position__r.id.equals(pid02)) {
                       Urls.add(jp.Employment_Website__r.Web_Address__c);
                   }
               }
            }
 
            for (String url : urls) {
                System.debug(url);
            }
 
            System.debug('**finish begin');
        }
}