public with sharing class email {
    public static void SendEmailTest(String url) {
        Position__c c =new Position__c();
        List<Job_Posting__c> jps = 
         [select Position__r.id from Job_Posting__c where Employment_Website__r.Web_Address__c = :url];
        for (Job_Posting__c jp : jps) {
        c.id = jp.Position__r.id;
         }
         
         
        List<String> messagess = new List<String>();
        List<Job_Application__c> jas = 
         [select Candidate__r.id from Job_Application__c where Position__r.id = :c.id];
        for (Job_Application__c ja : jas) {
        messagess.add(ja.Candidate__r.id);
         }
         
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        // Set recipients to two contact IDs.
        // Replace IDs with valid record IDs in your org.
        message.toAddresses = messagess;
        message.optOutPolicy = 'FILTER';
        message.subject = 'Opt Out Test Message';
        message.plainTextBody = 'This is a home work';
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
    

