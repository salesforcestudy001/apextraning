public class positionCanCountBatch implements Database.Batchable<sObject>, Database.stateful{

    List<ID> positionID = new List<ID>();
    Integer candidateCount;
    List<String> URL = new List<String>();
    public Database.QueryLocator start(Database.BatchableContext bc){
        //找出处理的记录
        String sql = 'select id from job_Application__c ';
        // System.debug(sql);
        return Database.getQueryLocator(sql);
    }
    public void execute(Database.BatchableContext bc, List<job_Application__c> records){
        // System.debug('execute');
        // for (job_Application__c j : records) {
        //    if (j.countcan >10) {
        //        positionID = j.position__c;
        //    }
        for (Aggregateresult count : 
                        [select position__r.id,count(candidate__r.id)countcan from job_Application__c group by position__r.id]) {
            candidateCount = Integer.valueOf(count.get('countcan'));
            System.debug(candidateCount);
            if (candidateCount > 2) {
                positionID.add((ID)count.get('id'));
                System.debug(positionID);
            }
        }
           List<Job_Posting__c> empWebList = 
                        [select Employment_Website__r.Web_Address__c from Job_Posting__c where Position__c in :positionID ];
           for (Job_Posting__c emp : empWebList) {
               URL.add(emp.Employment_Website__r.Web_Address__c);
               System.debug(emp.Employment_Website__r.Web_Address__c);
           }
        }

    public void finish(Database.BatchableContext bc){
        // System.debug('finish');
        System.debug(URL);        
    }
}
