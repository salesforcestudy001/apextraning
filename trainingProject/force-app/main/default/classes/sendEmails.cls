public with sharing class sendEmails {
    public static void sendEmails(string url) {
   // 根据输入的网站名(比如www.salesforce.com)从Employment Website检索出相关的Postion，
   //然后从Job_Application中找出申请该Position的candidate，给这些candidate发一封邮件。

        //根据url从employment_website__c中拿到employment_website__c的id
        //在job_posting__c表中找position（ job_posting__c中的employment_website__cd的id等于拿到的id的position）
        list<job_posting__c> position =[select position__c from job_posting__c where employment_website__c in (select id from employment_website__c where Web_Address__c = :url)];
       
        list<job_application__c> ca = new list<job_application__c>();
        // 从job_application__c中通过position找candidaie的email
        for(integer i = 0; i < position.size(); i++){
            list<job_application__c> res = [select candidate__r.id,candidate__r.Email__c  from job_application__c where position__c=:position[i].position__c];
            system.debug(res);
            for(integer j =0; j <res.size(); j++){//把所有的res中的candidate都放到ca里面。
                ca.add(res[j]);
            }
             system.debug(ca);
        }
        list<String> emails = new list<String>();
        for(job_application__c emaillist: ca ){
            emails.add(emaillist.candidate__r.Email__c);
        }
        system.debug(position );
        system.debug(ca);
        system.debug('em=' + emails);

        //发邮件
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        String[] toAddresses = emails;
        if(toAddresses.size() !=0){
            message.setToAddresses(toAddresses);
            message.optOutPolicy = 'FILTER';
            message.setSubject('Opt Out Test Message');
            message.setPlainTextBody('This is a home work');
            Messaging.SingleEmailMessage[] messages = 
            new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            system.debug(results);
            if (results[0].success) {
            System.debug('The email was sent successfully.');
            } else {
            System.debug('The email failed to send: '
            + results[0].errors[0].message);
            }
        }else{
            system.debug('不能为空！');
        }
 
    }
}
