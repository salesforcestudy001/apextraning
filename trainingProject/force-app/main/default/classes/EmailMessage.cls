public with sharing class EmailMessage {
    public static void EmailMessage(String URL) {

        List<Id> jobPostingId1 = new List<Id>();
        Id jobPostingId2;
        Id pId;
        Id eId;
        
        List<position__c> posList  = 
            [select id, name, (select id, name from Job_posting__r) from position__c];

        List<Employment_Website__c> EmWeURLList = 
            [select id,Web_Address__c from Employment_Website__c where Web_Address__c = :URL];

        for (Employment_Website__c Emid : EmWeURLList) {
            eId = emid.id;
        }

        List<Employment_Website__c> empWebList = 
            [select id, name, (select id, name from Job_posting__r) from Employment_Website__c where id = :eId];
        
        for (position__c po : posList) {
            for (Job_posting__c jp01 :  po.Job_posting__r) {
                jobPostingId1.add(jp01.id);
            }         
        }

        for (Employment_Website__c EmpWeJoList : empWebList) {
            for (Job_posting__c jp02 :  EmpWeJoList.Job_posting__r) {
                jobPostingId2 = jp02.id; 
                break;
            }              
        }
       
        for (ID jpid : jobPostingId1) {
            if (jpid.equals(jobPostingId2)) {
                pId = [select Position__r.id from Job_Posting__c where Job_Posting__c.id = :jpid].Position__r.id;
            }
        }

        // List<String> mgid = new List<String>();
        List<String> mgem = new List<String>();
        List<Job_Application__c> jobApList = 
            [select Candidate__r.id, Candidate__r.email__c from Job_Application__c where Position__r.id = :pId and Position__r.id != null];
            for (Job_Application__c ja : jobApList) {
                // mgid.add(ja.Candidate__r.id);
                if (ja.Candidate__r.email__c != null) {
                    mgem.add(String.valueof(ja.Candidate__r.email__c));
                }
            }
            System.debug('Mg=' + mgem);
            // System.debug(mgid);



         // Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        // // Set recipients to two contact IDs.
        // // Replace IDs with valid record IDs in your org.
        // // message.addAddresses('1870171585@qq.com');
        // message.settoAddresses(mgem);
        // message.optOutPolicy = 'FILTER';
        // // message.subject = 'Opt Out Test Message';
        // message.setSubject('test email subject use html');
        // message.plainTextBody = 'This is the message body.';
        // Messaging.SingleEmailMessage[] messages = 
        // new List<Messaging.SingleEmailMessage> {message};
        // Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        // if (results[0].success) {
        // System.debug('The email was sent successfully.');
        // } else {
        // System.debug('The email failed to send: '
        // + results[0].errors[0].message);
        // }


    }
 
}
