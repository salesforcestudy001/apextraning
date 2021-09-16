public with sharing class Newlist {
    public static void Newlist(list<string>positionName,list<string>candidateName) {
             try{
                 id postid;
                 id candid;

                 Integer postListSize;
                 Integer candListSize;

                 postListSize = positionName.size();
                 candListSize = candidateName.size();

                 Integer size;

                 if(postListSize>candListSize){
                     size=postListSize;
                     for(Integer i=candListSize;i<postListSize;i++){
                         candidateName.add(null);
                     }    
                 }
                 else {
                     size=candListSize;
                     for(Integer i =postListSize;i<candListSize;i++){
                         positionName.add(null);
                     }
                 }
            List<Job_Application__c> listJob =new list<Job_Application__c>();
            List<Review__c> ListReview = new list<Review__c>();
            for (candidate__c cand : [select id, name from candidate__c where name = :candidateName[i]]) {
                    candid = cand.id;
                    break;
            }
            for(position__c post :[select id, name from position__c where name = :positionName[i] ]){
            
                break;
        
            }
              Job_Application__c  JBA = new Job_Application__c();
              JBA.position__c=postid;
              JBA.candidate__c= candid;
              listJob.add(JBA);

             }

             insert listJob;

             for(Job_Application__c JBA : listJob){
                 review__c re =new review__c(Rating__c = 1,Job_Application__c = JBA.id);
                 listRev.add(re);
             }
             insert listRev;
    }

               //catch (Exception e){
                  // system.debug(e.getMessage());
              // }
}
