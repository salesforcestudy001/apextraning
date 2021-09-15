@isTest
public with sharing class factoryClassTest0915 {
    @testSetup
    static void setup(){
            factory.factoryCreate;
        }
    @isTest
    static void test01(){
        test.startTest();
        webTest wt = new wbTest();
        Database.executeBatch(wt,1);
        test.stopTest();
    }
}
