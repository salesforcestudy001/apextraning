public with sharing class factory {
    public static void positionDataCreate(){
        //
        Employment_Website__c testEmpoymentWeb001=new Employment_Website__c();
        testEmpoymentWeb001.name='baidu';
        testEmpoymentWeb001.Web_Address__c='www.baidu.com';
        testEmpoymentWeb001.Price_Per_Post__c=1;
        testEmpoymentWeb001.Maximum_Budget__c=1;
        insert testEmpoymentWeb001;
        //
        Employment_Website__c testEmpoymentWeb002=new Employment_Website__c();
        testEmpoymentWeb002.name='accenture';
        testEmpoymentWeb002.Web_Address__c='www.accenture.com';
        testEmpoymentWeb002.Price_Per_Post__c=1;
        testEmpoymentWeb002.Maximum_Budget__c=1;
        insert testEmpoymentWeb002;
        //
        position__c testPos001=new position__c();
        testPos001.name='testPos001';
        insert testPos001;
        //
        Job_Posting__c testJobPosting001=new Job_Posting__c();
        testJobPosting001.position__c=testPos001.id;
        testJobPosting001.Employment_Website__c=testEmpoymentWeb001.id;
        insert testJobPosting001;
        //
        Job_Posting__c testJobPosting002=new Job_Posting__c();
        testJobPosting002.position__c=testPos001.id;
        testJobPosting002.Employment_Website__c=testEmpoymentWeb002.id;
        insert testJobPosting002;
        //
        List<candidate__c> canTestLst = new List<candidate__c>();
        for (Integer i = 0; i < 11; i++) {
            candidate__c canTest=new candidate__c();
            canTestLst.add(canTest);
        }
        insert canTestLst;
        //
        List<job_application__c> jobappTestLst = new List<job_application__c>();
        for (Integer i = 0; i < 11; i++) {
            job_application__c jobappTest=new job_application__c();
            jobappTest.candidate__c=canTestLst[i].id;
            jobappTest.position__c=testPos001.id;
            jobappTestLst.add(jobappTest);
        }
        insert jobappTestLst;
    }
}
