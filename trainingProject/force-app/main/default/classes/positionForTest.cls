public with sharing class positionForTest {

    public static void setSalary(){
        for (list<position__c> positions : [select id,Max_Pay__c,Status__c from position__c]) {
            for (position__c pos : positions) {
                if (pos.Max_Pay__c>100) {
                    pos.Status__c='Closed - Canceled';
                }
            }
            update positions;
        }
    }
}
