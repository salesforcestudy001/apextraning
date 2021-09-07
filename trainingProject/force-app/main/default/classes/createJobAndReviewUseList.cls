public with sharing class createJobAndReviewUseList {
    public createJobAndReviewUseList() {

    }
    public void createJobApplication(List<string> positionNames,List<string> candidateNames){

        List<review__c> reviews = new List<review__c>();
        List<job_application__c> jobs = new List<job_application__c>();
        list<position__c> positions=[SELECT ID,NAME FROM Position__c where name in :positionNames];
        list<candidate__c> candidates=[SELECT ID,NAME FROM candidate__c where name in :candidateNames];
        list<job_application__c> jobList=[SELECT ID,NAME FROM job_application__c where candidate__r.name in :candidateNames];
        createJobAndReviewUseList.makeTwoStringSameSize(positionNames,candidateNames);
        try {
            for(integer i ;i<candidateNames.size();i ++){
                integer flag=0;
                id candidateID;
                id postionID;
                for (job_application__c ja  : jobList) {
                    if (ja.candidate__r.name==candidateNames[i]) {
                        flag=1;
                    }
                }
                for (candidate__c can  : candidates) {
                    if (can.name==candidateNames[i]) {
                        candidateID=can.id;
                    }
                }
                for (position__c pos  : positions) {
                    if (pos.name==positionNames[i]) {
                        postionID=pos.id;
                        break;
                    }
                }
                IF(flag==0){
                    Job_Application__c JOB=new Job_Application__c();
                    JOB.Position__c=posid;
                    JOB.candidate__C=canid;
                    JOBS.add(JOB) ;
                }else {
                throw new createException('存在');
                }

            }
            insert jobs;
            if(JOBS.size()>0){
                for (Job_Application__c jac : JOBS) {
                    REVIEW__C RE =new REVIEW__C(Job_Application__c=jac.ID,Rating__c=1);
                    REVIEWS.add(RE);
                }
            }else {
                throw new createException('存在');
            }
            insert REVIEWS;
            
        } catch (createException e) {
            System.debug('candiadatename is already exist');
            
        }catch(DMLEXCEPTION E ){
            System.debug('CREATED FAILURE');
        }

    }
    public static void makeTwoStringSameSize(List<string> positionNames,List<string> candidateNames){
        IF(positionNames.size()>=candidateNames.size()){
            INTEGER sizecha=positionNames.size()-candidateNames.size();
            for (integer i=0 ;i< sizecha;i++) {
                candidateNames.add(null);
            }
        }else {
            INTEGER sizecha=candidateNames.size()-positionNames.size();
            for (integer i=0 ;i< sizecha;i++) {
                positionNames.add(null);
            }
        }
    }
}
