public class testSendMail {
    EmailMissionSpecialist emailMissionSpecialist = new EmailMissionSpecialist();
    public void testSendMail(String mailAddress) {
        // Postion情报取得
        List<Job_Posting__c> jobPostings = [select Position__r.id from Job_Posting__c where Employment_Website__r.Web_Address__c = :mailAddress];
        List<String> positionIdList = new List<String>();
        for(Job_Posting__c jobPosting : jobPostings){
            positionIdList.add(jobPosting.Position__r.id);
        }
        // 获取mail地址
        List<Job_Application__c> jobApplications = [select Candidate__r.Email__c from Job_Application__c where Position__r.id in :positionIdList];
        for(Job_Application__c jobApplication : jobApplications){
            if(jobApplication.Candidate__r.Email__c != null){
                EmailMissionSpecialist.sendMail(jobApplication.Candidate__r.Email__c, 'test send mail', 'test send mail' );
            }
        }
    }
}
