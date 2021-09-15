public with sharing class jobApplicationWork0910 extends TriggerHandlerAdapter{
    //定义静态变量 jobAppDisabled
    public static boolean jobAppDisabled = false;
    //重写isDisabled方法,返回变量jobAppDisabled
    public override Boolean isDisabled() {
        return jobAppDisabled;
    }
    //重写beforeInsert方法
    public override void beforeInsert(List<SObject> newItems) {
        ApplicationBango((List<Job_Application__c>)newItems);
    }
    //重写afterInsert方法
    public override void afterInsert(Map<Id, SObject> newItems) {
        AverageSalary((Map<id,Job_Application__c>)newItems);
    }
    //重写afterUpdate方法
    public override void afterUpdate(Map<Id, SObject> newItems,Map<Id, SObject> oldItems){
        AverageSalary((Map<id,job_AppDisabled__c>)newItems/*,((Map<id,job_AppDisabled__c>oldItems))*/);
    }
    //重写afterDelete方法
    public override void afterDelete(Map<Id, SObject> oldItems) {
        AverageSalaryDelete((Map<id,job_AppDisabled__c>)oldItems);
    }
    //实现beforeInsert方法
    public void beforeInsert(List<job_application__c> jobApplications) {
        Map<Integer,job_application__c> mapJob = new Map<Integer,job_application__c>();
        Integer apps = 0;
        List<apps> lsti = new List<apps>();
        for(List<job_application__c> lstjac :[select ApplicationBango__c from Job_Application__c] ){
            for (job_application__c jac : lstjac) {
                Integer appBanGo = Integer.valueOf(jac.ApplicationBango__c.substring(0,9));
                lsti.add(appBanGo);
            }
        }
        lsti.short();
        apps = lsti[lsti.size()-1];
        for(Integer i=0;i<jobApplications.size();i++){
            String str = 'A';
            String maxBango = String.valueOf(apps+i+1);
            jobApplications[i].ApplicationBango__c = str + maxBango.leftPad(8,'0');
        }
    }
    //实现AverageSalary方法
    public void AverageSalary(Map<Id,job_application__c>JobApplications){
        Map<String,Double>AverageSalaryMap = new Map<String,Double>();
        set<candidate__c> candidates = new set<candidate__c>();
        for(AggregateResult result:[select avg(ExpectSalary__c),AverageSalary,candidate__c from job_application__c group by candidate__c]){
            AverageSalaryMap.put((string)results.get('candidate__c'),(double)results.get('AverageSalary'));
        }
        for(list<job_application__c>jobs:[select candidate__c,candidate__r.AverageSalary__c,Id from Job_Application__c where Id in :JobApplications.keySet()]){
            for (Job_Application__c job : jobs) {
                if(job.candidate__c != null){
                  job.candidate__r.AverageSalary__c = avgSalaryMap.get(job.candidate__c);
                  candidates.add(job.candidate__r);
                }
            }
        }
        list<candidate__c> canlist=new list<candidate__c>(candidates);
        update canlist;
    }
    //实现AverageSalaryDelete
    public void AverageSalaryDelete(Map<id,job_AppDisabled__c>jobApplications){
        Map<String,Double>AverageSalaryMap = new Map<String,Double>();
        for (AggregateResult results
                : [select avg(ExpectSalary__c)avgSalary,candidate__c from Job_Application__c where Id not in :JobApplications.keySet() group by candidate__c]) {
                    AverageSalaryMap.put((string)results.get('candidate__c'),(double)results.get('avgSalary'));                
        }
        for (list<Job_Application__c> jobs : [select candidate__c,candidate__r.AverageSalary__c,Id from Job_Application__c where Id in :JobApplications.keySet()]) {
            for (Job_Application__c job : jobs) {
                if(job.candidate__c!=null){
                  job.candidate__r.AverageSalary__c=AverageSalaryMap.get(job.candidate__c);
                  candidates.add(job.candidate__r);
                }
            }
        }
        list<candidate__c> canlist=new list<candidate__c>(candidates);
        update canlist;
    }
}
