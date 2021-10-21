public with sharing class Cancontroller {
    @AuraEnabled(cacheable=true)
    public static List<Candidate__c> getCandidatelist(String getKey,Integer page){
        String newKey=getKey;
        page=page*10;
        return[
            select Name,Name__c,age__c,Phone__c,Email__c,Education__c from Candidate__c
            where Name__c like :newKey
            limit 10 offset: page
        ];
    }
    @AuraEnabled
    public static void deleteCand(List<string> NameId){
    list<Candidate__c> deleteData=[select id from Candidate__c where id in:NameId ];
    delete deleteData;
    }
}
