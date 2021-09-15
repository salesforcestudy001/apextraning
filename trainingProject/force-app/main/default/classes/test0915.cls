public with sharing class test0915 {
    public static void positiontest(){
        position__c p = new position__c();
        p.Name = 'postion001';
        insert p;

        Employment_Website__c ew = new Employment_Website__c();
        ew.Name = 'salesforce';
        ew.Web_Address__c = 'www.salesforce.com';
        ew.Price_Per_Post__c = 10;
        ew.Maximum_Budget__c = 50;
        insert ew;

        Job_Posting__c jp = new Job_Posting__c();
        jp.Employment_Website__c = ew.id;
        jp.Position__c = p.id;
        insert jp;

        List<candidate__c> canList = new List<candidate__c>();
        for (Integer i = 0; i < 11; i++) {
            candidate__c canTest=new candidate__c();
            canList.add(canTest);
        }
        insert canList;
        //
        List<job_application__c> jobList = new List<job_application__c>();
        for (Integer i = 0; i < 11; i++) {
            job_application__c jobTest=new job_application__c();
            jobTest.candidate__c=canList[i].id;
            jobTest.position__c=p.id;
            jobList.add(jobTest);
        }
        
        insert jobList;
    }
}
