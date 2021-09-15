public with sharing class classCreateList {
    public classCreateList(List<String> positionName,List<String> candidateName) {
        map<id, candidate__c> canmap =new map<id, candidate__c>([select id,name from candidate__c ]) ;
        map<id, Position__c> posmap =new map<id, Position__c>([select id,name from Position__c ]) ;
     
        id candidateID;
        id positionID;

        integer can = candidateName.size();
        integer pos = positionName.size();
        integer all;
        
        if (can >= pos) {
           
            all = can;
            for(integer i = pos; i < can; i++){
                    positionName.add(null);
                }
            }else{
            
                all = pos;
            for(integer i = can; i < pos; i++){
                    candidateName.add(null); 
                }
            
        }
        List<job_application__c> jo = new List<job_application__c>();
        List<review__c> re = new List<review__c>();

    try {
        for(integer i = 0; i < all; i++){
            for (id canidKey : canmap.keyset()) {

                candidate__C canTemp = canmap.get(canidKey);
                if(canTemp.name == candidatename[i]){
                    candidateID = canTemp.id;
                    System.debug('存在');
                    break;
                }else {
                    candidateID = null;
                }
            }
            for (id posidKey : posmap.keyset()) {
                position__c posTemp = posmap.get(posidKey);
                if(posTemp.name == positionname[i]){
                    positionID = posTemp.id;
                    System.debug('存在');
                    break;
                }else {
                    positionID = null;
                }
            }

                Job_Application__c job = new Job_Application__c();
                job.Position__c = positionID;
                job.candidate__c = candidateID;
                jo.add(job);
        
            }
            insert jo;
 
            for(job_application__c jac : jo){
                review__c theReview = new review__c(Rating__c = 1,Job_Application__c = jac.id);
                re.add(theReview);
                }

            insert re;
        }

    catch(EXCEPTION E ){
        System.debug(E.getMessage());
        }
    }
}

