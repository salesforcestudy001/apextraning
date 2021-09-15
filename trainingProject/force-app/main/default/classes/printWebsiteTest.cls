@isTest
public class printWebsiteTest {
    @testSetup 
    static void Setup() {
        ceshi.positionDataCreate();
    }
    @isTest
    static void test01(){
        test.startTest();
        printWeb pw=NEW printWeb();
        Database.executeBatch(pw,1);
        test.stopTest();
    }
}