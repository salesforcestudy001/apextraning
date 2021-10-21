public with sharing class candidateHomework {
    
    @AuraEnabled(cacheable=true)
    public static list<Candidate_Test__c> getCandidates(string name){
        if (name == null) {
            return [select Name, Candidate_Name__c, Candidate_Age__c, Candidate_Phone__c, Candidate_Email__c, Candidate_Education__c from Candidate_Test__c];
        }else {
            string search = '%' + name + '%';
            return [select Name, Candidate_Name__c, Candidate_Age__c, Candidate_Phone__c, Candidate_Email__c, Candidate_Education__c from Candidate_Test__c 
                    where Candidate_Name__c like :search
                    order by Name ASC];
        }
        
    }
    @AuraEnabled
    public static void deleteCandidates(list<string> ids){
        list<Candidate_Test__c> cans=[select Id from Candidate_Test__c where id in :ids];
        // System.debug(cans);
        delete cans;
        //return cans;
    }

}
