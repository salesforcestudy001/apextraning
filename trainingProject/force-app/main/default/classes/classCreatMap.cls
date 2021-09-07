public with sharing class classCreatMap {
    public static void classCreatMap(list<String> positionNames, list<String> candidateNames) {
        try {
            id candidateId;
            id positionId;

            Integer caSize = candidateNames.size();
            Integer poSize = positionNames.size();
            
            integer longListSize = 0;
            if(caSize>=poSize){
                longListSize = caSize;
                for(integer o = poSize; o <caSize; o++){
                    positionNames.add(null);
                }
            }
                
            else {
                longListSize=poSize;
                for(integer o = poSize; o <caSize; o++){
                    candidateNames.add(null);
                }
            }
    
            Map<ID, position__c> positionMap = new Map<ID, position__c>
                                           ([SELECT id,name FROM position__c WHERE name IN :positionNames]);
            Map<ID, candidate__c> candidateMap = new Map<ID, candidate__c>
                                           ([SELECT id,name FROM candidate__c WHERE name IN :candidateNames]);
           
            list<job_application__c> ja = new list<job_application__c>();
            list<review__c> ree = new list<review__c>();

            for(candidate__c can :candidateMap.values()){
                system.debug(can.name);
            }
            

            for(integer i=0; i<longListSize; i++){  
                
                //for(String cnames : candidateNames ){
                 //   system.debug(cnames);
                     for(candidate__c can :candidateMap.values()){
                         system.debug(can.name);
                        if(candidateNames[i] == can.name){
                            candidateId=can.id;
                            system.debug(candidateId);
                            break; 
                        } else {
                            candidateId = null;
                        }                                          
                     }
               // }

                //for(String pnames : positionNames){
                    for(position__c posi :positionMap.values()){
                        if(positionNames[i] == posi.name){
                            system.debug(posi.id);
                            positionId=posi.id;
                            break;
                        }else {
                            positionId = null;
                        }
                    }
             
                //}
                
                job_application__c joo = new job_application__c();
                joo.position__c=positionId;
                joo.candidate__c=candidateId;
                ja.add(joo);

            }
            
            insert ja;
           for(job_application__c jja:ja){
               review__c rre = new review__c(job_application__c= jja.id,rating__c=1);
               ree.add(rre);
          }
            insert ree;
        } catch (Exception e) {
            system.debug(e.getMessage());
        }
    }
}

