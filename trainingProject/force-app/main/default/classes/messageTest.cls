public with sharing class messageTest {
    public static void messageTests(String strs) {
        Position__c pc;
        List<Job_Posting__c> jobpostings = [select position__r.id from job_posting__c where employment_website__r.web_address__c = :strs];
        for (Job_Posting__c jpc : jobpostings) {
            pc.id = jpc.position__r.id;
            //break;
        }
        
        List<String> messagess = new List<String>();
        List<Job_Application__c> jobapplications = [select candidate__r.id ,candidate__r.email__c from job_application__c where position__r.id = :pc.id];
            for (Job_Application__c jac : jobapplications) {
                if ((jac.candidate__r.email__c) != null) {
                    messagess.add(jac.candidate__r.email__c);
                }
            }

            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            // message.toAddresses = messagess;
            // message.optOutPolicy = 'FILTER';
            // message.subject = 'Opt Out Test Message';
            // message.plainTextBody = 'sent work';
            message.setToAddresses(messagess);
            message.setSenderDisplayName('the sender name you want to show');
            message.setHtmlBody('AyachiNene');
            message.setSubject('test email subject use html');
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            if (results[0].success) {
                System.debug('This email is testEmail,The email was sent successfully.');
            } else {
                System.debug('The email failed to send: '+ results[0].errors[0].message);
            }
    }
}
