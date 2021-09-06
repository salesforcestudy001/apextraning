public with sharing class createjobandrevie {
    public createjobandrevie() {

    }
    public void createJobApplication(list<string> positionNames,list<string> candidateName){
        //list for Job_Application__c and REVIEW__C to insert all results
        List<Job_Application__c> JOBS = new List<Job_Application__c>();
        List<REVIEW__C> REVIEWS = new List<REVIEW__C>();
        //map for all select results
        Map<ID, candidate__C> canMap =new Map<ID, candidate__C>([SELECT ID,NAME FROM candidate__C where  name in :candidateName ]) ;
        Map<ID, Position__c> posMap =new Map<ID, Position__c>([SELECT ID,NAME FROM Position__c where name in :candidateName]) ;
        Map<ID, Job_Application__c> jaMap =new Map<ID, Job_Application__c>([SELECT ID,candidate__R.NAME FROM Job_Application__c where candidate__R.NAME in :candidateName]) ;
        //make two string lists have the same size
        IF(positionNames.size()>=candidateName.size()){
            INTEGER sizecha=positionNames.size()-candidateName.size();
            for (integer i=0 ;i< sizecha;i++) {
                candidateName.add(null);
            }
        }else {
            INTEGER sizecha=candidateName.size()-positionNames.size();
            for (integer i=0 ;i< sizecha;i++) {
                positionNames.add(null);
            }
        }
        try {
            //
            for (integer i=0 ;i< candidateName.size();i++) {
                /*List<candidate__C> can =[SELECT ID,NAME FROM candidate__C WHERE NAME=:candidateName[i] ];
                INTEGER II=[SELECT COUNT() FROM Job_Application__c WHERE candidate__R.NAME=:candidateName[i] ];
                List<Position__c> POS =[SELECT ID,NAME FROM Position__c WHERE NAME=:positionNames[i] ];*/

                //flag for  finding candidateName in job_application
                integer flag=0;
                //id for candidate and position 
                id canid;
                id posid;
                //if have the same candidateName ,set flag=1
                for (ID jaidKey : jaMap.keyset()) {
                    Job_Application__c jaTemp=jaMap.get(jaidKey);
                    if(jaTemp.candidate__R.NAME==candidateName[i]){
                        flag=1;
                    }
                }
                //if have the same candidateName,set id
                for (ID canidKey : canMap.keyset()) {
                    candidate__C canTemp = canMap.get(canidKey);
                    if(canTemp.NAME==candidateName[i]){
                        canid=canTemp.id;
                    }
                }
                //if have the same positionNames,set id
                for (ID posidKey : posMap.keyset()) {
                    position__C posTemp = posMap.get(posidKey);
                    if(posTemp.NAME==positionNames[i]){
                        posid=posTemp.id;
                        break;
                    }
                }
                //flag==0 status create job_app else throw exception
                IF(flag==0){
                    Job_Application__c JOB=new Job_Application__c();
                    JOB.Position__c=posid;
                    JOB.candidate__C=canid;
                    JOBS.add(JOB) ;
                }else {
                throw new createexception('存在');
            }
        }
        insert JOBS;
        //if jobs not null ,create realated review,else throw exception
        if(JOBS.size()>0){
            for (Job_Application__c jac : JOBS) {
                REVIEW__C RE =new REVIEW__C(Job_Application__c=jac.ID,Rating__c=1);
                REVIEWS.add(RE);
            }
        }else {
            throw new createexception('存在');
        }
        insert REVIEWS;
        //catch exception
        } catch (createexception e) {
           System.debug('candiadatename is already exist');
            
        }catch(DMLEXCEPTION E ){
            System.debug('CREATED FAILURE');
            }

}
}

