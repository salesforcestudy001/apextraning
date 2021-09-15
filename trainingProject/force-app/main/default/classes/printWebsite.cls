/*
 *                        _oo0oo_
 *                       o8888888o
 *                       88" . "88
 *                       (| -_- |)
 *                       0\  =  /0
 *                     ___/`---'\___
 *                   .' \\|     |// '.
 *                  / \\|||  :  |||// \
 *                 / _||||| -:- |||||- \
 *                |   | \\\  - /// |   |
 *                | \_|  ''\---/''  |_/ |
 *                \  .-\__  '-'  ___/-. /
 *              ___'. .'  /--.--\  `. .'___
 *           ."" '<  `.___\_<|>_/___.' >' "".
 *          | | :  `- \`.;`\ _ /`;.`/ - ` : | |
 *          \  \ `_.   \_ __\ /__ _/   .-` /  /
 *      =====`-.____`.___ \_____/___.-`___.-'=====
 *                        `=---='
 * 
 * 
 *      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * 
 *            佛祖保佑       永不宕机     永无BUG
 */
/* 给大家留一个作业，实现如下batch。检索所有position,当满足postion申请的candidate人数超过10个人的时候，
将发布该postion的网站在finish里打印出来。batch size设置为1。 */
public with sharing class printWebsite  implements Database.Batchable<sObject>,Database.stateful {

    map<id,List<string>> Websites;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('**start begin');
        Websites=new map<id,List<string>>();
        string sql='select id,(select id,candidate__c from job_application__r),name from position__c';
        System.debug('**start end');
        return Database.getQueryLocator(sql);
      }
    public void execute(Database.BatchableContext bc, List<position__c> records){
        System.debug('**excute begin');
        Set<id> canId = new Set<id>();
        list<string> strWebsites=new list<string>();
        for (position__c pos : records) {
            //Set<id> canId = new Set<id>();
            if (pos.job_application__r.size()!=0) {
                for (job_application__c job : pos.job_application__r) {
                  canId.add(job.candidate__c);
                }
            }
            if (canId.size()>10) {
              for(list<Job_Posting__c> jobPostings:[select Employment_Website__r.Web_Address__c,position__c from Job_Posting__c]){
                for (Job_Posting__c jobPosting : jobPostings) {
                    if (jobPosting.position__c==pos.id) {
                      strWebsites.add(jobPosting.Employment_Website__r.Web_Address__c);
                    }
                }
              }
            }
            Websites.put(pos.id,strWebsites);
        }               
        System.debug('**excute end');
      }
    public void finish(Database.BatchableContext bc){
        System.debug('**finish begin');
        for (id posid : Websites.keyset()) {
          if (Websites.get(posid).size()>0) {
            System.debug(posid+' have more than 10 candidates');
            for (string str : Websites.get(posid)) {
              System.debug(str);
            }
          } else {
            System.debug(posid+' dont have more than 10 candidates');
          }
        }
      }

}
