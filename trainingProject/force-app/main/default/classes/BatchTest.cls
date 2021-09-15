@isTest
public with sharing class BatchTest {
    static testmethod void BatchTest() {
        factory.factory();
        
        Test.startTest();
        positionBatch ba = new positionBatch();
        Database.executeBatch(ba,1);
        Test.stopTest();
    }
}