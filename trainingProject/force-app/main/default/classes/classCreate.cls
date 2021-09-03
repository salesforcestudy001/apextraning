public class classCreate {
    public void createJobApplication(list<string> positionName,list<string> candidateName){
        try{
           //①、业务check，当candidateName已经存在于job_application中的时候，用system.debug提示错误信息
           integer i=[select count() from job_application__c where candidate__r.name=:candidateName];
            if (i>0){
                throw new applicationException('该用户已经存在');
            }     
           //②、创建job Application
           id candidateId;
           id positionId;
           //取出candidate ID
           for (candidate__c candidate:[select id,name from candidate__c where name=:candidateName]){
               candidateId=candidate.id;
               break;
           }
            //取出postion id
           for (position__c position:[select id,name from position__c where name=:positionName]){
               positionId=position.id;
               break;
           }
           //根据取出的postion ID和candidate ID创建job_application__c           
           job_application__c theJobapplication=new job_application__c();
           theJobapplication.position__c=positionId;
           theJobapplication.candidate__c=candidateId;
           insert theJobapplication;
           //③、创建review
           review__c theReview =new review__c();
           theReview.Job_Application__c=theJobapplication.id;
           theReview.Rating__c=1;
           insert theReview;
        }catch(exception e){
            system.debug(e.getMessage());
        }
   	   //④、如果创建过程中出现错误，请打出错误信息      
    }
}