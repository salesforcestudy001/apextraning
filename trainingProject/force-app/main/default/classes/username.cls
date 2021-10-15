public with sharing class username {
    @AuraEnabled(cacheable=true)
    public static List<userslogin__c> getUsername() {
        return [
            SELECT Id, Username__c
            FROM userslogin__c
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<userslogin__c> getId(String name){
        return [
            SELECT Id
            FROM userslogin__c
            WHERE Username__c = :name
        ];
    }
}
