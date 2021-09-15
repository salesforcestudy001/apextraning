@isTest
public  class BatchHomeWorkTest {
    static testmethod void test01() {
        FactoryDate.createTestRecords();
        // Run some tests
        BathHomework bh = new BathHomework();
        database.executeBatch(bh,1);
    }
}