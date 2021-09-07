public with sharing class createJobAndReviewUseList {
    public createJobAndReviewUseList() {

    }
    public void createJobApplication(List<string> positionNames,List<string> candidateNames){

        List<review__c> reviews = new List<review__c>();
        List<job_application__c> jobs = new List<job_application__c>();
        list<position__c> positions=[SELECT ID,NAME FROM Position__c where name in :positionNames];
        list<candidate__c> candidates=[SELECT ID,NAME FROM candidate__c where name in :candidateNames];
    }
}
