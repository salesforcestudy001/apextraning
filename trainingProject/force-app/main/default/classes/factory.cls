public with sharing class factory {
    public static  void factory(){
        position__c po = new position__c(name = 'firstTest');
        insert po;

        list<candidate__c> canList = new list<candidate__c>();
        for(integer i = 0; i<15; i++){
            candidate__c can = new candidate__c();
            canList.add(can);
        }
        insert canList;

        list <job_application__c> jobList = new list<job_application__c>();
        for(candidate__C can : canList){
            job_application__c job = new job_application__c(candidate__c = can.id,position__c = po.id);
            jobLIst.add(job);
        }
        insert jobList;

        Employment_Website__c ew = new Employment_Website__c(name = '666',Web_Address__c = '777',Price_Per_Post__c = 1,Maximum_Budget__c = 10);
        insert ew;
        job_posting__c jobP = new job_posting__c(position__c = po.id,Employment_Website__c = ew.id );
        insert jobP;
    }
}

