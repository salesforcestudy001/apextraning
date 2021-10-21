public with sharing class CandidateController {
    @AuraEnabled(cacheable=true)
    public static List<Candidate__c> getCandidateList(String searchKey,Integer page) {
        String key = '%' + searchKey + '%';
        page=page*10;
        return [
            SELECT Name,Name__c,age__c,Phone__c,Email__c,Education__c
            FROM Candidate__c
            WHERE Name__c LIKE :key 
            LIMIT 10 offset : page
        ];
    }
    @AuraEnabled
    public static void deleteCandidate(List<string> NameId) {
       list<Candidate__c> deleteData= [select id from Candidate__c where id in :NameId];
        delete deleteData;

    }
    

}
