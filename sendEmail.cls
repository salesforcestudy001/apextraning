public with sharing class sendEmail {
    public void sendEmail(String address, String subject, String body) {

        job_posting__c jobPosting=[select Position__c from job_posting__c where Employment_Website__r.Web_Address__c=:website];
        position__c position =[select id,name from position__c where id=:jobposting.Position__c];

        list<Job_Application__c> Jobs =[SELECT candidate__R.NAME FROM Job_Application__c WHERE POSITION__R.NAME=:position.name];
             
            List<candidate__c> listCandidate = [select name,email__c from candidate__c ];
            list<string> emailAdddresses=new list<string>();
        
            for (Job_Application__c JOB : Jobs) {
                for (candidate__c candidate : listCandidate) {
                    if(candidate.name==job.candidate__R.name){
                        emailAdddresses.add(candidate.email__c);
                    }
                }
            }
 // 创建email类
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        // 建立一个发送邮件的方法 
        // Email类
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
              new Messaging.SingleEmailMessage[] { mail });   
        // 调用helper方法来检查返回的结果
        inspectResults(results);
    }
    // Helper method
    private static Boolean inspectResults(Messaging.SendEmailResult[] results) {
        Boolean sendResult = true;
        // sendEmail返回一个结果对象数组.
        // 遍历列表以检查结果. 
        // 在这个类，发送一封电子邮件, 
        for (Messaging.SendEmailResult res : results) {
            if (res.isSuccess()) {
                System.debug('Email sent successfully');
            }
            else {
                sendResult = false;
                System.debug('The following errors occurred: ' + res.getErrors());                 
            }
        }
        return sendResult;
    }
}
