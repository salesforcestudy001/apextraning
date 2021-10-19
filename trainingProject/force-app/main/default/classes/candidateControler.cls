public with sharing class candidateControler {
        @AuraEnabled(cacheable=true)
        public static list<Candidate2__c> getCandidates(string name){
            if (name==null) {
                return [select CandidateNo__c,Name,Age__c,Phone__c,Email__c,Education__c from Candidate2__c];
            }else {
                string search='%'+name+'%';
                return [select CandidateNo__c,Name,Age__c,Phone__c,Email__c,Education__c from Candidate2__c 
                        where Name like :search
                        order by CandidateNo__c ASC];
            }
            
        }
        @AuraEnabled
        public static void deleteCandidates(list<string> ids){
            list<Candidate2__c> cans=[select id from Candidate2__c where id in :ids];
            System.debug(cans);
            delete cans;
            //return cans;
        }
}
