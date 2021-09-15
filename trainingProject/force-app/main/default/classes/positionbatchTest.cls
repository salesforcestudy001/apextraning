@isTest
public with sharing class positionbatchTest {
    @TestSetup
    static void Setup() {
        test0915.positiontest();
    }
    @isTest
    static void test01(){
        test.startTest();
        positionbatch pb=NEW positionbatch();
        Database.executeBatch(pb,1);
        test.stopTest();
    }
}