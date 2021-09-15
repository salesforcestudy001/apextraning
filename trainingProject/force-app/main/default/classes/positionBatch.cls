public with sharing class positionBatch implements Database.Batchable <sObject>, Database.Stateful{
    
    list<string> website = new list<string>();
    
    public Database.QueryLocator start(Database.BatchableContext bc){     
        string sql = 'select id from position__c';       
        return Database.getQueryLocator(sql);
    }

    public void execute(Database.BatchableContext bc, List<position__c> records){
        list<job_posting__c>jobpostAll = [select position__c,Employment_Website__r.Web_Address__c from job_posting__c];
        
        for(position__c pos: records){
            set<ID> setId = new set<ID>();
            for(list<job_application__c> jobApp:[select position__c, candidate__c from job_application__c]){
                for(job_application__c jobs:jobApp){
                    if(pos.id == jobs.position__c){
                         setId.add(jobs.candidate__c);
                     }
                }  
            }
            if(setId.size()>10){
                String webUrl = '';
                for(job_posting__c jobpost: jobpostAll ){
                    if(pos.id == jobpost.position__c){
                        webUrl = jobpost.Employment_Website__r.Web_Address__c;
                        website.add(webUrl);
                        system.debug(website);
                    }
                }
            }
        }
    }

    public void finish(Database.BatchableContext bc){
        for (String w : website) {
            System.debug(w);
        }

    }
}
