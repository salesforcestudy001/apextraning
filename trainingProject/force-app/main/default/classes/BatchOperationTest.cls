@isTest
public class BatchOperationTest {
    static testmethod void test1() {
        BatchOperationFactory.BatchOperationFactory();
        Test.startTest();
        BatchOperation batchOperation = new BatchOperation();
        database.executeBatch(batchOperation);
        Test.stopTest();
    }
}
