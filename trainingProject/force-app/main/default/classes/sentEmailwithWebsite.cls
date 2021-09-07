public with sharing class sentEmailwithWebsite {
    public sentEmailwithWebsite() {

    }
    public static void sentEmail(string website){
        /*Employment_Website__c websiteAddress=[select id,(select name from Job_Posting__r)from Employment_Website__c where Web_Address__c=:website limit 1];
        position__c  position =[select id,name from position__c wehre Job_Posting__r.name=:websiteAddress.Job_Posting__r.name];
        list<Job_Application__c> JOBS=[SELECT candidate__R.NAME FROM Job_Application__c WEHRE POSITION__R.NAME=:position.NAME];
        List<candidate__c> listCandidate = [select email from candidate__c ];*/
        job_posting__c jobposting=[select Position__c from job_posting__c where Employment_Website__r.Web_Address__c=:website];
        //position__c position =[select id,name from position__c where id=:jobposting.Position__c];
        String name =[select id,name from position__c where id=:jobposting.Position__c][0].name;
        list<Job_Application__c> JOBS =[SELECT candidate__R.NAME FROM Job_Application__c WHERE POSITION__R.NAME=:name];
        List<candidate__c> listCandidate = [select email__c from candidate__c ];
        list<string> emailadddresses=new list<string>();
        for (Job_Application__c JOB : JOBS) {
            for (candidate__c candidate : listCandidate) {
                if(candidate.email__c==job.candidate__R.name){
                    emailadddresses.add(candidate.email__c);
                }
            }
        }
        for(string str:emailadddresses){
            IF(str!=null){
                EmailManager em = new EmailManager();
                em.sendMail(str, 'subject', ' body');
            }
            
        }
    }
}
