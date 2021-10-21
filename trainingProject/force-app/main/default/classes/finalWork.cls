public with sharing class finalWork {
    // [select CandidateNo__c,Designation__c,Age__c,Phone__c,Email__c,Education__c from Candidate__c]
    @AuraEnabled(cacheable=true)
    public static List <Candidate__c> CandidateList (string Firstname,Integer page) {
        string search ='%'+ Firstname +'%';
        page=page*10;
        return [select CandidateNo__c,Designation__c,Age__c,Phone__c,Email__c,Education__c 
                from Candidate__c 
                where  Designation__c like: search 
                limit 10 offset : page
                ];
    }

    @AuraEnabled
    public static void minHandler (List<string> FirstNameId) {
        list<Candidate__c> deleteData =[select id from Candidate__c where id in:FirstNameId];
        delete deleteData;
    }
}