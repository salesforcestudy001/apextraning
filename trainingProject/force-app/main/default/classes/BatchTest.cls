@isTest
public with sharing class BatchTest {
    static testmethod void BatchTest() {
        factory.factory();
        positionBatch ba = new positionBatch();
        Database.executeBatch(ba,1);
    }
}
