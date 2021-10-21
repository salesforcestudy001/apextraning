public with sharing class CandidateValue {
    @AuraEnabled(cacheable=true)
    public static List <Candidate__c> CandidateList (string Firstname,Integer page) {
        string search ='%'+ Firstname +'%';
        page=page*10;
        return [SELECT Name,First_Name__c,Age__c,Phone__c,Email__c,Education__c 
                FROM Candidate__c 
                WHERE  First_Name__c like: search 
                LIMIT 10 offset : page
                ];
    }

    @AuraEnabled
    public static void minHandler (List<string> FirstNameId) {
        list<Candidate__c> deleteData =[select id from Candidate__c where id in:FirstNameId];
        delete deleteData;
    }

  
}



