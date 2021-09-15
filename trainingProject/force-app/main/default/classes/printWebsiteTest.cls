@isTest
public with sharing class printWebsiteTest {
    @testSetup 
    static void Setup() {
        factory.positionDataCreate();
    }
    @isTest
    static void test01(){
        test.startTest();
        printWebsite pw=NEW printWebsite();
        Database.executeBatch(pw,1);
        test.stopTest();
    }
}
