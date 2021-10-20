public with sharing class sotsugyou {

    // 查出所有的用户
    @AuraEnabled(cacheable=true)
    public static List<Candidate__c> getCandidate(String PageIndex) {
        System.debug(PageIndex);
        return [select Id,Name,Last_Name__c,Age__c,Email__c,Phone__c,SSN__c,Education__c from Candidate__c limit 2];
    }

    // 根据名字模糊查询
    @AuraEnabled
    public static List<Candidate__c> selectCandidateByName(String Last_Name) {
        String key = '%' + Last_Name + '%';
        System.debug(key);
        return [select Id,Name,Last_Name__c,Age__c,Email__c,Phone__c,SSN__c,Education__c from Candidate__c where Last_Name__c like :key];
    }

    // 更改完查出所有用户
    @AuraEnabled
    public static List<Candidate__c> selectCandidate() {
        return [select Id,Name,Last_Name__c,Age__c,Email__c,Phone__c,SSN__c,Education__c from Candidate__c ];
    }

    // 删除数据库中的数据
    @AuraEnabled
    public static List<Candidate__c> deleteCandidateById(List<String> Ids){
        List<Candidate__c> canList = new List<Candidate__c>();
        System.debug('Start Delete');
        Set<String> idSet = new Set<String>();
        for(String Id : Ids){
            idSet.add(Id);
        }
        for (String IdOfSet : idset) {
            Candidate__c c = new Candidate__c(Id = IdOfSet);
            canList.add(c);
        }
        System.debug(canList);
        delete canList;
        return [select Id,Name,Last_Name__c,Age__c,Email__c,Phone__c,SSN__c,Education__c from Candidate__c];
    }
}
