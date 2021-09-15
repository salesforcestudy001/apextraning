public with sharing class addcontent {
    public static void test1(){
        // add new  Employment_Website__c
        Employment_Website__c test001=new Employment_Website__c();
        test001.name='salesforce';
        test001.Web_Address__c='www.salesforce.com';
        test001.Price_Per_Post__c=1;
        test001.Maximum_Budget__c=1;
        insert test001;
        //add new  Employment_Website__c
        Employment_Website__c test002=new Employment_Website__c();
        test002.name='accenture';
        test002.Web_Address__c='www.accenture.com';
        test002.Price_Per_Post__c=2;
        test002.Maximum_Budget__c=2;
        insert test002;
        // add new position__c
        Position__c testP001=new Position__c();
        testP001.name='testP001';
        insert testP001;
        // add new Job_Posting__c
        Job_Posting__c JPc001=new Job_Posting__c();
        JPc001.Position__c=testP001.id;
        JPc001.Employment_Website__c=test001.id;
        insert JPc001;
        //add new Job_Posting__c
        Job_Posting__c JPc002=new Job_Posting__c();
        JPc002.Position__c=testP001.id;
        JPc002.Employment_Website__c=test002.id;
        insert JPc002;
        //List<candidate__c>
        List<candidate__c> canTestLst = new List<candidate__c>();
        for (Integer i = 0; i < 11; i++) {
            candidate__c canTest=new candidate__c();
            canTestLst.add(canTest);
        }
        insert canTestLst;
        //List<job_application__c>
        List<job_application__c> jobss = new List<job_application__c>();
        for (Integer i = 0; i < 11; i++) {
            job_application__c jobappTest=new job_application__c();
            jobappTest.candidate__c=canTestLst[i].id;
            jobappTest.Position__c=testP001.id;
            jobss.add(jobappTest);
        }
        insert jobss;
    }
}
