public with sharing class factory {
    public static void factory() {
        
        // 测试数据
        position__c p = new position__c();
        p.Name = 'test01';
        insert p;

        candidate__c c = new candidate__c();
        c.First_Name__c = 'a';
        c.Last_Name__c = 'b';
        insert c;

        job_Application__c ja = new job_Application__c();
        ja.Position__c = p.id;
        ja.Candidate__c = c.id;
        insert ja;

        Employment_Website__c e = new Employment_Website__c();
        e.Name = 'salesforce';
        e.Web_Address__c = 'www.salesforce.com';
        e.Price_Per_Post__c = 3;
        e.Maximum_Budget__c = 6;
        insert e;

        Job_Posting__c jp = new Job_Posting__c();
        jp.Employment_Website__c = e.id;
        jp.Position__c = p.id;
        insert jp;

    }
}
