public with sharing class test915 {
    public void main() {
        List<position__c>positionLst=new list<position__c>();
        for (position__c p:[SELECT id,max_pay__c,status__c  FROM position__c])
             if(p.max_pay__c>=100){
                 p.status__c='closed - Cabceled';
                 positionLst.add(p);
             }
             update positionLst;
    }

}
