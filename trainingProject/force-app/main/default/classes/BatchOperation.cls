public class BatchOperation implements Database.Batchable<sObject>,Database.Stateful{
    List<Job_Posting__c> jobPostings;
    public Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('***start begin');
        String sql = 'select id from Position__c';
        return Database.getQueryLocator(sql);
    }
    public void execute(Database.BatchableContext bc, List<Position__c> records){
        System.debug('***execute begin');
        jobPostings = new List<Job_Posting__c>();
        for(Position__c position : records){
            Integer countNumber = [select count() from Job_Application__c where Position__c =: position.id and Candidate__c != null];
            if(countNumber > 10){
                jobPostings = [select Employment_Website__r.Web_Address__c from Job_Posting__c where Position__r.id =: position.Id];
            }
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('***finish begin');
        for (Job_Posting__c jobPosting : jobPostings) {
            System.debug(jobPosting.Employment_Website__r.Web_Address__c);
        }
    }
}