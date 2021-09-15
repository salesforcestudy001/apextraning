public with sharing class printWeb implements Database.Batchable<SObject>,Database.stateful {
    List<String> web = new List<String>();
     public Database.QueryLocator start(Database.BatchableContext bc)
     {
         System.debug('**start begin');
         String q='select id,(select id,candidate__c from job_application__r) from position__c';
         return Database.getQueryLocator(q);
     }
     public void execute(Database.BatchableContext bc,List<position__c> records)
     {
         System.debug('**execute begin');
         for (list <Job_Posting__c> jpList  :[select Employment_Website__r.Web_Address__c,position__c from Job_Posting__c]) 
         {
             for (position__c pos : records) {
                 Set<Id> si = new Set<Id>();
                
                 
                     for(job_application__c ja : pos.job_application__r)
                     {
                         si.add(ja.candidate__c);
                     }
                 
                 if (si.size()>10) 
                 {
                    for (Job_Posting__c jp : jpList) 
                    {
                        if (jp.position__c==pos.id) 
                        {
                            web.add(jp.Employment_Website__r.Web_Address__c);
                        }    
                    }    
                 }
             }
         }
     }
    public void finish(Database.BatchableContext bc)
    {
        System.debug('**finish begin');
        for (string str : web)
        {
            System.debug(str);
        }
    } 
}
