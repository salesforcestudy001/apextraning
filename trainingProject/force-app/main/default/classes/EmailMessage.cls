public with sharing class EmailMessage {
    public static void EmailMessage(String URL) {

        Id jobPostingId1;
        Id jobPostingId2;
        Id pId;
        position__c p = new position__c();;

        List<position__c> posList  = new List<position__c>([select id, name, (select id, name from Job_posting__r) from position__c]);
        List<Employment_Website__c> empWebList = new List<Employment_Website__c>([select id, name, (select id, name from Job_posting__r) from Employment_Website__c]);
        for (position__c po : posList) {
            pId = po.id;
            for (Job_posting__c jp01 :  po.Job_posting__r) {
                jobPostingId1 = jp01.id;
                break;
            }         
        }
        for (Employment_Website__c EmpWeJoList : empWebList) {
            for (Job_posting__c jp02 :  EmpWeJoList.Job_posting__r) {
                jobPostingId1 = jp02.id;
                break;
            }              
        }

        List<Employment_Website__c> EmWeURLList = new List<Employment_Website__c>([select id,Web_Address__c from Employment_Website__c where Web_Address__c = :URL]);

        if (jobPostingId1 == jobPostingId2) {
            p.id = pId;
        }

        List<String> mg = new List<String>();
        List<Job_Application__c> jobApList = 
            [select Candidate__r.id from Job_Application__c where Position__r.id = :p.id];
            for (Job_Application__c ja : jobApList) {
                mg.add(ja.Candidate__r.id);
            }

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        // Set recipients to two contact IDs.
        // Replace IDs with valid record IDs in your org.
        message.toAddresses = mg;
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
