public class classRead {
    public void readJobApplication(string candiateName){
        //①、根据candidate名、将job_application和相关的review信息打印出来。如果没找到candidate，请显示“not found the candidate”
        list<job_application__c> jobapplicationLst=[select id,position__r.name,candidate__r.name,(select id,Rating__c from Review__r) from job_application__c where candidate__r.name=:candiateName];
        if (jobapplicationLst==null || jobapplicationLst.size()==0){
            system.debug('not found the candidate');
        }else{
            for (job_application__c theJobApp:jobapplicationLst){
                system.debug('**candidateName='+theJobApp.candidate__r.name);
                for (review__c theView:theJobApp.Review__r){
                    system.debug('****review.Rating='+theView.Rating__c);
                }
            }
        }
    }
}