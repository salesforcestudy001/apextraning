//检索所有position,当满足postion申请的candidate人数超过10个人的时候，
//将发布该postion的网站在finish里打印出来。batch size设置为1
public class Dobatch  implements database.Batchable<sobject>,Database.stateful{
    List<String> link=new List<String>();
    public Database.QueryLocator start (Database.BatchableContext bc){
       // system.debug('***start');
        String sql='select id,(select id,candidate__c from job_application__r)from position__c';
        return Database.getQueryLocator(sql);
    }
    public void execute(Database.BatchableContext bc, List<position__c> records){
       //System.debug('***execute');
     for(list<Job_Posting__c> jpc:[select Employment_Website__r.Web_Address__c,position__c from Job_Posting__c]){
         for (position__c pos : records) {
             Set<id> canId = new Set<id>();
                 for (job_application__c job : pos.job_application__r) {
                   canId.add(job.candidate__c);
                 }
             
             if (canId.size()>10) {
                 for (Job_Posting__c jobPosting : jpc) {
                     if (jobPosting.position__c==pos.id) {
                         link.add(jobPosting.Employment_Website__r.Web_Address__c);
                     }
                 }
             }
         }               
 }
 
 }
     public void finish(Database.BatchableContext bc){
      // System.debug('***finish');
       for (string li : link) {
           System.debug(li);
   }
 
 }
 }