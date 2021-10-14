public with sharing class userScyControl {

    @AuraEnabled(cacheable=true)
    public static list<UserScy__c> getRecords(){
        return [select Username__c from UserScy__c];
    }
}
