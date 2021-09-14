/* 给大家留一个作业，实现如下batch。检索所有position,当满足postion申请的candidate人数超过10个人的时候，
将发布该postion的网站在finish里打印出来。batch size设置为1。 */
public with sharing class printWebsite  implements Database.Batchable<sObject>,Database.stateful {

    List<string> Websites= new List<string>();
    public Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('**start begin');
        string sql='select id,(select id,candidate__c from job_application__r) from position__c';
        System.debug('**start end');
        return Database.getQueryLocator(sql);
      }
    public void execute(Database.BatchableContext bc, List<position__c> records){
        System.debug('**excute begin');
        for(list<Job_Posting__c> jobPostings:[select Employment_Website__r.Web_Address__c,position__c from Job_Posting__c]){
                for (position__c pos : records) {
                    Set<id> canId = new Set<id>();
                    if (pos.job_application__r.size()!=0) {
                        for (job_application__c job : pos.job_application__r) {
                          canId.add(job.candidate__c);
                        }
                    }
                    if (canId.size()>10) {
                        for (Job_Posting__c jobPosting : jobPostings) {
                            if (jobPosting.position__c==pos.id) {
                                Websites.add(jobPosting.Employment_Website__r.Web_Address__c);
                            }
                        }
                    }
                }               
        }
        System.debug('**excute end');
      }
    public void finish(Database.BatchableContext bc){
        System.debug('**finish begin');
          for (string str : Websites) {
            System.debug(str);
          }
      }

}
