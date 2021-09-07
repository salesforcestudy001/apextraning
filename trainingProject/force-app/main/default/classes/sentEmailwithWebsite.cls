public with sharing class sentEmailwithWebsite {
    public sentEmailwithWebsite() {

    }
    public void sentEmail(string website){
        Employment_Website__c websiteAddress=[select id,Job_Posting__r.name from Employment_Website__c where Web_Address__c=:website limit 1];
        position__c  position =[select id,name from position__c wehre Job_Posting__r.name=:websiteAddress.Job_Posting__r.name];
        list<Job_Application__c> JOBS=[SELECT candidate__R.NAME FROM Job_Application__c WEHRE POSITION__R.NAME=:position.NAME];
        List<candidate__c> listCandidate = [select email from candidate__c ];
        list<string> emailadddresses=new list<string>();
        for (Job_Application__c JOB : JOBS) {
            for (candidate__c candidate : listCandidate) {
                if(candidate.email==job.candidate__R.name){
                    emailadddresses.add(candidate.email);
                }
            }
        }
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        // Set recipients to two contact IDs.
        // Replace IDs with valid record IDs in your org.
        message.toAddresses = emailadddresses;
        message.optOutPolicy = 'FILTER';
        message.subject = 'Opt Out Test Message';
        message.plainTextBody = 'This is the message body.';
        Messaging.SingleEmailMessage[] messages = 
            new List<Messaging.SingleEmailMessage> {message};
         Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            if (results[0].success) {
                System.debug('The email was sent successfully.');
            } else {
                System.debug('The email failed to send: '
                + results[0].errors[0].message);
            }
    }
}
