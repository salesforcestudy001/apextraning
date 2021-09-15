@isTest
public class FactoryDate {
    public static void createTestRecords() {
 
        Position__c p = new Position__C(name = 'test01');
        Insert p;
 
        List<Candidate__c> cans = new List<Candidate__c>();
        for (Integer i = 0;i < 13 ; i ++) {
            Candidate__C c = new Candidate__c();
            cans.add(c);
            // Insert c;
            // Job_Application__c ja = new Job_Application__c(candidate__c = c.id,position__c = p.id);
            // Insert ja; 
        }
        Insert cans;
 
        List<Job_Application__c> jas = new List<Job_Application__c>();
        for (Candidate__c c : cans) {
            Job_Application__c ja = new Job_Application__c(candidate__c = c.id,position__c = p.id);
            jas.add(ja);
        }
        Insert jas;
 
        Employment_Website__c ew = new Employment_Website__c(Name = '百度',Web_Address__c = 'www.baidu.com',Price_Per_Post__c = 10,Maximum_Budget__c = 10);
        Insert ew;
        Job_Posting__c jp = new Job_Posting__c(position__c = p.id,Employment_Website__c = ew.id);
        Insert jp;
 
    }
}