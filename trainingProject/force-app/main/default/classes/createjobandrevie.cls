public with sharing class createjobandrevie {
    public void createJobApplication(list<string> positionName,list<string> candidateName){
        List<Job_Application__c> JOBS = new List<Job_Application__c>();
        List<REVIEW__C> REVIEWS = new List<REVIEW__C>();
        Map<ID, candidate__C> canMap =new Map<ID, candidate__C>([SELECT ID,NAME FROM candidate__C where  name in :candidateName ]) ;
        Map<ID, Position__c> posMap =new Map<ID, Position__c>([SELECT ID,NAME FROM Position__c where name in :candidateName]) ;
        Map<ID, Job_Application__c> jaMap =new Map<ID, Job_Application__c>([SELECT ID,candidate__R.NAME FROM Job_Application__c where candidate__R.NAME in :candidateName]) ;
        IF(positionName.size()>=candidateName.size()){
            INTEGER sizecha=positionName.size()-candidateName.size();
            for (integer i=0 ;i< sizecha;i++) {
                candidateName.add(null);
            }
        }else {
            INTEGER sizecha=candidateName.size()-positionName.size();
            for (integer i=0 ;i< sizecha;i++) {
                positionName.add(null);
            }
        }
        try {
            for (integer i=0 ;i< candidateName.size();i++) {
                integer flag=0;
                id canid;
                id posid;
                for (ID jaidKey : jaMap.keyset()) {
                    Job_Application__c jaTemp=jaMap.get(jaidKey);
                    if(jaTemp.candidate__R.NAME==candidateName[i]){
                        flag=1;
                    }
                }
                for (ID canidKey : canMap.keyset()) {
                    candidate__C canTemp = canMap.get(canidKey);
                    if(canTemp.NAME==candidateName[i]){
                        canid=canTemp.id;
                    }
                }
                for (ID posidKey : posMap.keyset()) {
                    position__C posTemp = posMap.get(posidKey);
                    if(posTemp.NAME==positionName[i]){
                        posid=posTemp.id;
                        break;
                    }
                }
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
        if(JOBS.size()>0){
            for (Job_Application__c jac : JOBS) {
                REVIEW__C RE =new REVIEW__C(Job_Application__c=jac.ID,Rating__c=1);
                REVIEWS.add(RE);
            }
        }else {
            throw new createexception('存在');
        }
        insert REVIEWS;
        } catch (createexception e) {
           System.debug('candiadatename is already exist');
            
        }catch(DMLEXCEPTION E ){
            System.debug('CREATED FAILURE');
            }

}
}

