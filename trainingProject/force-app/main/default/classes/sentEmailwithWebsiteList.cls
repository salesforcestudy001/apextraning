public with sharing class sentEmailwithWebsiteList {
    public sentEmailwithWebsiteList() {

    }
    public static void sentEmail(list<string> websites){
        //find records that webaddress equals website in Employment_Website__c by job_posting__c using soql
        list<job_posting__c> jobPostings=[select Position__c from job_posting__c where Employment_Website__r.Web_Address__c in :websites];
        //find position's names which id in jobposting
        list<id> positionID=new list<id>();
        for (job_posting__c postingTemp : jobPostings) {
            positionID.add(postingTemp.Position__c);
        }
        list<position__c> positions =[select id,name from position__c where id in :positionID];
        List<string> positionsNames = new List<string>();
        for (position__c pos : positions) {
            positionsNames.add(pos.name);
        }
        //find jobapplication related candidate's name which related position's name equals above position's name
        list<Job_Application__c> Jobs =[SELECT candidate__R.NAME FROM Job_Application__c WHERE POSITION__R.NAME in :positionsNames];
        //find all candidate 
        List<candidate__c> listCandidate = [select name,email__c from candidate__c ];
        list<string> emailAdddresses=new list<string>();
        //find right address ,then add into list
        for (Job_Application__c JOB : Jobs) {
            for (candidate__c candidate : listCandidate) {
                if(candidate.name==job.candidate__R.name){
                    emailAdddresses.add(candidate.email__c);
                }
            }
        }
        //if emailaddress not null send the email
        integer count=0;
        for(string str:emailAdddresses){
            if(str!=null){
                EmailManager em = new EmailManager();
                em.sendMail(str, 'thie is a test email', ' Email sent successfully');
                count++;
            }else{
                system.debug('Candidate have no emails!');
            }
            system.debug('Sent '+count+' emails!');
        }
    }
}
