@isTest
public with sharing class batchTest {
    @TestSetup
    static void makeData(){
        factory.factory();
    }
    
    static testMethod void testo1(){
        Test.startTest();
        positionCanCountBatch b1 = new positionCanCountBatch();
        Database.executeBatch(b1);
        Test.stopTest();
    }
}
