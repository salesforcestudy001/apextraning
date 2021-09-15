@isTest
public  class BatchTestClass {
    @TestSetup
    static void makeData(){
        Factory.createTestRecords();
    }
    static testmethod void test01() {

        // Run some tests
        Test.startTest();
        BetchHW bhw = new BetchHW();
        database.executeBatch(bhw);
        Test.stopTest();
    }
}
