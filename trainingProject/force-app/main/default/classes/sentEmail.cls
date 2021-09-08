public with sharing class sentEmail {
    public static void sentEmail(string website){
        //find record that webaddress equals website in Employment_Website__c by job_posting__c using soql
        job_posting__c jobPosting=[select Position__c from job_posting__c where Employment_Website__r.Web_Address__c=:website];
        //find position's name which id in jobposting
        position__c position =[select id,name from position__c where id=:jobposting.Position__c];
        //find jobapplication related candidate's name which related position's name equals above position's name
        list<Job_Application__c> Jobs =[SELECT candidate__R.NAME FROM Job_Application__c WHERE POSITION__R.NAME=:position.name];
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
        for(string str:emailAdddresses){
            if(str!=null){
                EmailManager em = new EmailManager();
                em.sendMail(str, 'subject', ' body');
            }
        }
    }
}
