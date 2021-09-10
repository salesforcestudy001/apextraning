public with sharing class JobApplicationTriggerHandler extends TriggerHandlerAdapter{
    public static Boolean triggerDisabled = FALSE;

    public override Boolean isDisabled() {
      return triggerDisabled;
    }
    public override void beforeInsert(List<SObject> newItems) {
        addApplicationBango((List<Job_Application__c>) newItems);
    }
    public override void afterInsert(Map<Id, SObject> newItems ) {
        avgSalary((Map<Id, Job_Application__c>) newItems);
    }
    public override void afterUpdate(Map<Id, SObject> newItems,Map<Id, SObject> oldItems) {
        avgSalary((Map<Id, Job_Application__c>) newItems);
    }
    public override void beforeDelete(Map<Id, SObject> oldItems) {
        avgSalaryforDelete((Map<Id, Job_Application__c>) oldItems);
    }
    public void addApplicationBango(List<Job_Application__c> JobApplications){
        map<integer,Job_Application__c> jobmap=new map<integer,Job_Application__c>();
        integer maxBango=0;
        list<integer> Bangos=new list<integer>();
        for(List<Job_Application__c> JobLists :[select ApplicationBango__c  from Job_Application__c]){
            for (Job_Application__c job : JobLists) {
                integer bango =integer.valueOf(job.ApplicationBango__c.substring(1,9));
                Bangos.add(bango);
            }
        }
        Bangos.sort();
        maxBango=Bangos[Bangos.size()-1];
        for (integer m=0;m<JobApplications.size();m++) {
            integer strlen;
            integer bangolen=0;
            for(integer temp=maxBango+m+1;temp!=0;temp/=10){
                bangolen++;
            }
            String template='A';
            strlen=9-bangolen-1;
            for (integer j=0 ;j<strlen;j++) {
                template=template+'0';
            }
            integer finalBango=maxBango+m+1;
            JobApplications[m].ApplicationBango__c=template+finalBango;
        }
    }
    public void avgSalary(Map<Id, Job_Application__c> JobApplications){
        Map<string, double> avgSalaryMap = new Map<string, double>();
        list<candidate__c> candidates=new list<candidate__c>();
        for (AggregateResult  results 
                : [select avg(ExpectSalary__c)avgSalary,candidate__c from Job_Application__c  group by candidate__c]) {                    
                        avgSalaryMap.put((string)results.get('candidate__c'),(double)results.get('avgSalary'));
                }
        for (list<Job_Application__c> jobs : [select candidate__c,candidate__r.AverageSalary__c,Id from Job_Application__c where Id in :JobApplications.keySet()]) {
            for (Job_Application__c job : jobs) {
                if(job.candidate__c!=null){
                  job.candidate__r.AverageSalary__c=avgSalaryMap.get(job.candidate__c);
                  candidates.add(job.candidate__r);
                }
            }
        }
        update candidates;
    }
    public void avgSalaryforDelete(Map<Id, Job_Application__c> JobApplications){
        Map<string, double> avgSalaryMap = new Map<string, double>();
        list<candidate__c> candidates=new list<candidate__c>();
        for (AggregateResult results
                : [select avg(ExpectSalary__c)avgSalary,candidate__c from Job_Application__c where Id not in :JobApplications.keySet() group by candidate__c]) {
                        avgSalaryMap.put((string)results.get('candidate__c'),(double)results.get('avgSalary'));                
        }
        for (list<Job_Application__c> jobs : [select candidate__c,candidate__r.AverageSalary__c,Id from Job_Application__c where Id in :JobApplications.keySet()]) {
            for (Job_Application__c job : jobs) {
                if(job.candidate__c!=null){
                  job.candidate__r.AverageSalary__c=avgSalaryMap.get(job.candidate__c);
                  candidates.add(job.candidate__r);
                }
            }
        }
        update candidates;
    }

}