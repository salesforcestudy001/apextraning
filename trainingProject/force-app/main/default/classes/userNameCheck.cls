public with sharing class userNameCheck {
    @AuraEnabled(cacheable=true)
    public static List<ptxx__c> userName(String searchTerm) {
        return [
            SELECT Id
            FROM ptxx__c
            WHERE Username__c = :searchTerm
            WITH SECURITY_ENFORCED
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<String> userNameCheck(string fld) {
        List < String > allOpts = new list < String > ();
        Schema.sObjectType objType = ptxx__c.getSObjectType();
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        list < Schema.PicklistEntry > values =
            fieldMap.get(fld).getDescribe().getPickListValues();
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        allOpts.sort();
        return allOpts;
    }
 }
