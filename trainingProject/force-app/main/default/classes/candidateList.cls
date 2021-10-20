public with sharing class candidateList {

    @AuraEnabled(cacheable=true)
    public static Integer getCount(){
        System.debug('getcount');
        Integer i;
        for (Aggregateresult count : [SELECT count(id)cc FROM Candidate__c]) {
            System.debug(1);
            i = Integer.valueOf(count.get('cc'));
            System.debug('for+' + i);
        }
        System.debug(i);
        return i;
    }

    @AuraEnabled
    public static List<candidate__c> getCandidateList(String firstName, String lastName,Integer page) {
        page = page * 3;
        String first = '%' + firstName + '%';
        String last = '%' + lastName + '%';
        return [
            SELECT Id, Name, First_Name__c, Last_Name__c, Phone__c, Email__c, Education__c  
            FROM Candidate__c
            WHERE First_Name__c like :first or Last_Name__c like :last 
            LIMIT 3 offset :page
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<candidate__c> getCandidateListAll(Integer page) {
        page = page * 3;
        return [
            SELECT Id, Name, First_Name__c, Last_Name__c, Phone__c, Email__c, Education__c  
            FROM Candidate__c
            LIMIT 3 offset :page
        ];
    }

    @AuraEnabled
    public static List<candidate__c> deleteById(List<String> IdList, Integer page){
        List<candidate__c> canList = new List<candidate__c>();
        Set<String> canId = new Set<String>();
        for (String ids : IdList) {
            canId.add(ids);
        }
        System.debug(canId);

        for (String cid : canId) {
            candidate__c c = new candidate__c(Id = cid);
            canList.add(c);
        }
        System.debug(canList);

        delete canList;

        return[SELECT Id, Name, First_Name__c, Last_Name__c, Phone__c, Email__c, Education__c  FROM Candidate__c LIMIT 3 offset :page];
    }
}
