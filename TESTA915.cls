public with sharing class TESTA915 {
 static testmethod void test915(){
position__c p = new position__c();
p.name='test915';
p.max_pay__c='101';
p.status__c='new position';
insert p;
test915 ts =new test915();
ts.main();
position__c result=[select id,max_pay__c,status__c from position__c where id=:p.id];
system.assertEquals(result, Max_pay__c,101);
system.assertEquals(result,Status__c,'close canceled');



 }
}
