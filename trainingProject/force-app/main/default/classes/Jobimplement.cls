public with sharing class Jobimplement {
//申請番号会自动採番、採番的格式是「A00000001」
public static void addApplicationBango(List<Job_Application__c> JobApplications){
    list<integer> Bangos=new list<integer>();
    for(List<Job_Application__c> JbList :[select id,ApplicationBango__c  from Job_Application__c]){
        for (Job_Application__c jac : JbList) {
            if (jac.ApplicationBango__c != null) {
            integer bango =integer.valueOf(jac.ApplicationBango__c.substring(1,9));
            //get 00000001 add Bangos.list
            Bangos.add(bango);
        }else {
            jac.ApplicationBango__c = 'A00000000';
        }
    }
    System.debug(Bangos);
    Bangos.sort();//sort
   integer maxBango=Bangos[Bangos.size()-1];//MaxBango
    for (integer i=0;i<JobApplications.size();i++) {
        String first='A';
        string p=string.valueOf(maxBango+i+1);
        JobApplications[i].ApplicationBango__c=first+p.leftpad(8,'0');
    
}
    }
}
    // 当Job_Application发生增删改的时候，根据Job_Application里的希望給料，算出改Candidate的所有的【平均希望給料】，
    // 保存到Candidate的平均希望給料里。

 public static void avgSalary(Map<Id, Job_Application__c> JobApplications){
    Map<string, double> avgSalaryMap = new Map<string, double>();
    set<candidate__c> candidates=new set<candidate__c>();
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
    list<candidate__c> canlist=new list<candidate__c>(candidates);
    update canlist;
}

public static void avgSalaryforDelete(Map<Id, Job_Application__c> JobApplications){
    Map<string, double> avgSalaryMap = new Map<string, double>();
    set<candidate__c> candidates=new set<candidate__c>();
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
    list<candidate__c> canlist=new list<candidate__c>(candidates);
    update canlist;
}

}