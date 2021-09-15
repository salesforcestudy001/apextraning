public with sharing class batchWork0914 implements Database.Batchable<SObject>,Database.stateful {
    Map<id,List<String>> positionBatch;
    public Database.QueryLocator start(Database.BatchableContext bc){
        positionBatch = new Map<id,List<String>>();
        String sql = 'select id,(candition__c from job_application__c),name,(select Employment_website__r.Website_Address__c from job_posting__r) from postition__c';
        return Database.getQueryLocator(sql);
    }
    public void execute(Database.BatchableContext bc,List<postition__c> records){
        Set<Id> sid = new Set<Id>();
        List<String> lst = new List<String>();
        for(postition__c pc : records){
            if(pc.job_application__r.size()!=0){
                for(job_application__c jac : pc.job_application__r){
                    sid.add(jac.candidate__c);
                }
            }
            if(sid.size()>10){
                for(job_posting__c jpc : pc.job_posting__r){
                    lst.add(jpc.Employment_website__r.web_address__c);
                }
            }
            positionBatch.put(pc.id, lst);
        }
    }
    public void finish(Database.BatchableContext bc){
        for(id posid : positionBatch.keySet()){
            if(positionBatch.get(posid).size()>0){
                system.debug(posid+'超过10条');
                for(String str : positionBatch.get(posid)){
                    system.debug(str);
                }
            }else {
                system.debug(posid+'没超过10条');
            }
        }
    }
}
