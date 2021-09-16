/* 给大家留一个作业，实现如下batch。检索所有position,当满足postion申请的candidate人数超过10个人的时候，
将发布该postion的网站在finish里打印出来。batch size设置为1。 */

public with sharing class PositionBatchPlus implements Database.Batchable<sObject>,Database.stateful{

    List<String> urls = new List<String>();

    public Database.QueryLocator start(Database.BatchableContext bc){
        String sql = 'select id,name,(select Candidate__c from Job_Application__r),(select Employment_Website__r.Web_Address__c  from Job_posting__r) from Position__C';
        return Database.getQueryLocator(sql);
    }

    public void execute(Database.BatchableContext bc, List<position__c> records){   
        Set<ID> cID = new Set<ID>();
        for (Position__c p : records) {
            // Set<ID> cID = new Set<ID>();
           if(p.Job_Application__r.size() > 0){
                for (Job_Application__c ja : p.Job_Application__r) {
                    cID.add(ja.Candidate__c);
                }
           }
           if (cID.size() > 1) {
               for (Job_posting__c jp : p.Job_posting__r) {
                urls.add(jp.Employment_Website__r.Web_Address__c);
               }
           } 
        }
    }

    public void finish(Database.BatchableContext bc){
        for (String url : urls) {
            System.debug(url);
        }
    }
}
