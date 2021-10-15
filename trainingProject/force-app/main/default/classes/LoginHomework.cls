public with sharing class LoginHomework {


    // 获取用户信息
    @AuraEnabled(cacheable=true)
    public static List<YuziUsers__c> getUserList() {
        System.debug('getUsers');
        return [select Id,Name,User_Name__c,Country__c,Email__c from YuziUsers__c];
    }

    // 插入用户信息
    @AuraEnabled()
    public static void insertYuzi(String UserName ,String Email,String Country){
        System.debug('InsertUsers');
        System.System.debug('UserName: ' + UserName);
        System.System.debug('Email: ' + Email);
        System.System.debug('Country: ' + Country);
        YuziUsers__c yuziUser = new YuziUsers__c(User_Name__c = UserName,Email__c = Email,Country__c = Country);
        insert yuziUser;
 
    }

    // 获得下拉列表的值
    @AuraEnabled(cacheable=true)
    public static List<String> getPickList(String fld){
        List < String > allOpts = new list < String > ();

        Schema.sObjectType objType = YuziUsers__c.getSObjectType();
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
