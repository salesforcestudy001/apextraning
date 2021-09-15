public with sharing class positionbatch implements Database.Batchable<sObject>,Database.stateful{
    List<String> str=new List<String>();
    public Database.QueryLocator start(Database.BatchableContext bc){
        string sql='select id,(select id,candidate__c from job_application__r),(select id,Employment_Website__r.Web_Address__c from job_posting__r) from position__c';
        return Database.getQueryLocator(sql);
    }
    public void execute(Database.BatchableContext bc,List<position__c> records){
        set<id> canid=new set<id>();
        for(position__c p:records){
            for (job_application__c job :p.job_application__r) {
                canid.add(job.candidate__c);
            }
            if (canid.size()>10) {
                for (job_posting__c jobposting : p.job_posting__r) {
                    str.add(jobposting.Employment_Website__r.Web_Address__c);
                }
            }
           
        }       
    }
    public void finish(Database.BatchableContext bc){
        for(String s:str){
            System.debug(s);
        }
    }
}
