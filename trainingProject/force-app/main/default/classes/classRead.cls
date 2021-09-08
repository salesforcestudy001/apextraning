public class classRead {
    public void readJobApplication(string candiateName){
        //①、根据candidate名、将job_application和相关的review信息打印出来。如果没找到candidate，请显示“not found the candidate”
        List<Job_Application__c> jobApplications = [select id, name, Candidate__r.name, 
        (select id,Rating__c  from Review__r) from Job_Application__c where Candidate__r.name =: candiateName];
        if (jobApplications.size() == 0){
           System.debug('not found the candidate');
        }else{
            System.debug(jobApplications.size());
            for(Job_Application__c jobApp : jobApplications){
                System.debug('###jobApplicationName:' + jobApp.name);
                for(Review__c review : jobApp.Review__r){
                    System.debug(review.Rating__c);
            	}
            }    
        }
    }
}