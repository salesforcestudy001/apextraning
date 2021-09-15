public with sharing class factory {
    public static void factoryCreate() {
        //test01
        employment_website__c webTest01 = new employment_website__c();
        webTest01.name='salesforce';
        webTest01.website_address__c='www.salesforce.com';
        webTest01.price_per_post__c=1;
        webTest01.Maximum_budget__c=1;
        insert webTest01;

        //test02
        employment_website__c webTest02 = new employment_website__c();
        webTest02.name='github';
        webTest02.website_address__c='www.github.com';
        webTest02.price_per_post__c=1;
        webTest02.Maximum_budget__c=1;
        insert webTest02;

        //position__c test
        position__c positionTest01 = new postition__c();
        positionTest01.name='positionTest';
        insert positionTest01;

        //job_posting__c test01
        job_posting__c postingTest01 = new job_posting__c();
        postingTest01.postition = positionTest01.id;
        postingTest01.employment_website__c = webTest01.id;
        insert postingTest01;

        //job_posting__c test02
        job_posting__c postingTest02 = new job_posting__c();
        postingTest02.position = positionTest01.id;
        postingTest02.employment_website__c = webTest02.id;
        insert postingTest02;

        //candidate__c test
        List<candidate__c> candidateLet = new List<candidate__c>();
        for(Integer i=0;i<11;i++){
            candidate__c candidateTest = new candidate__c();
            candidateLet.add(candidateTest);
        }
        insert candidateLet;

        //job_application__c test
        List<job_application__c> applicationLet = new List<job_application__c>();
        for(Integer j=0;j<11;j++){
            job_application__c applicationTest = new job_application__c();
            applicationTest.candidate__c = candidateLet[i].id;
            applicationTest.position__c = positionTest01.id;
            applicationLet.add(applicationTest);
        }
        insert applicationLet;
    }
}
