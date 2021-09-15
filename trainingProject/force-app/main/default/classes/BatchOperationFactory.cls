public class BatchOperationFactory {
    public static void BatchOperationFactory(){
        Position__c position = new Position__c();
        insert position;
        for(Integer numContact=0;numContact<11;numContact++){
            Candidate__c candidate = new Candidate__c();
            insert candidate;
            Job_Application__c job = new Job_Application__c(Position__c=position.id,Candidate__c=candidate.id);
            insert job;
        }
        Employment_Website__c employmentWebsite = new Employment_Website__c(Web_Address__c = 'ww.baidu.com',Price_Per_Post__c=1000,Maximum_Budget__c=2000);
        insert employmentWebsite;
        Job_Posting__c jobPosting = new Job_Posting__c(Position__c = position.id,Employment_Website__c=employmentWebsite.id);
        insert jobPosting;
    }
}
