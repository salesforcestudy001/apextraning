public with sharing class EmailMessage {
    public static void EmailMessage(String URL) {

        Id jobPostingId1;
        Id jobPostingId2;
        Id pId;
        position__c p = new position__c();

        List<position__c> posList  = new List<position__c>([select id, name, (select id, name from Job_posting__r) from position__c]);
        List<Employment_Website__c> empWebList = new List<Employment_Website__c>([select id, name, (select id, name from Job_posting__r) from Employment_Website__c]);
        for (position__c po : posList) {
            pId = po.id;
            //System.debug(pId);
            for (Job_posting__c jp01 :  po.Job_posting__r) {
                jobPostingId1 = jp01.id;
                
                break;
            }         
        }
        for (Employment_Website__c EmpWeJoList : empWebList) {
            for (Job_posting__c jp02 :  EmpWeJoList.Job_posting__r) {
                jobPostingId2 = jp02.id; 
                break;
            }              
        }
        //System.debug(jobPostingId1);
        //System.debug(jobPostingId2);
        List<Employment_Website__c> EmWeURLList = new List<Employment_Website__c>([select id,Web_Address__c from Employment_Website__c where Web_Address__c = :URL]);

        if (jobPostingId1.equals(jobPostingId2)) {
            p.id = pId;
            System.debug(p.id);
        }

        List<String> mgid = new List<String>();
        List<String> mgem = new List<String>();
        List<Job_Application__c> jobApList = 
            [select Candidate__r.id, Candidate__r.email__c from Job_Application__c where Position__r.id = :p.id];
            for (Job_Application__c ja : jobApList) {
                mgid.add(ja.Candidate__r.id);
                mgem.add(String.valueof(ja.Candidate__r.email__c));
            }
            System.debug('Mg=' + mgem);

            


        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        // Set recipients to two contact IDs.
        // Replace IDs with valid record IDs in your org.
        // message.addAddresses('1870171585@qq.com');
        message.settoAddresses(mgem);
        message.optOutPolicy = 'FILTER';
        // message.subject = 'Opt Out Test Message';
        message.setSubject('test email subject use html');
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


        // Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        // email.setSenderDisplayName('the sender name you want to show');
        // // email.setHtmlBody('<span color="red">测试html body内容</span>');
        // // email.setSubject('test email subject use html');
        // email.subject = 'Opt Out Test Message';
        // email.plainTextBody = 'SQR';
        // //addresses which you wanna send to
        // // List<String> toAddresses = new List<String>();
        // // toAddresses.add('xx@qq.com');
        // email.setToAddresses(mgem);
        // Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});
        

    }


  
        
    
}
