@istest
public with sharing class testPositionForTest {

    static testMethod void test1(){
        position__c test001=new position__c(name='test001',Max_Pay__c=101,Status__c='New Position');
        insert test001;
        test.startTest();
        positionForTest.setSalary();
        test.stopTest();
        position__c testTemp=[select name,Status__c from position__c where name='test001'];
        system.assertEquals('Closed - Canceled',testTemp.Status__c);
    }

}

