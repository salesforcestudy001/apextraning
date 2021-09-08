public with sharing class SendEmail {

//     给大家留个作业，实现如下功能：
// 根据输入的网站名(比如www.salesforce.com)从Employment Website检索出相关的Postion，
// 然后从Job_Application中找出申请该Position的candidate，给这些candidate发一封邮件。
// 发邮件的方法请参照如下文档：


    public static void SendEmailTest(String url) {

        Position__c c  = new Position__c();

        List<Job_Posting__c> jps = 
            [select Position__r.id from Job_Posting__c where Employment_Website__r.Web_Address__c = :url];
        for (Job_Posting__c jp : jps) {
            c.id = jp.Position__r.id;
            break;
        }
        
        


        List<String> canEmails = new List<String>();
        List<Job_Application__c> jas = 
            [select Candidate__r.id ,Candidate__r.Email__c from Job_Application__c where Position__r.id = :c.id];
            for (Job_Application__c ja : jas) {
                if((ja.Candidate__r.Email__c) != null){
                    canEmails.add(ja.Candidate__r.Email__c);
                }     
            }
            
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setToAddresses(canEmails);
            message.setSenderDisplayName('the sender name you want to show');
            message.setHtmlBody('AyachiNene');
            message.setSubject('test email subject use html');
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
