public with sharing class creatListMap {
    public static void creatListMap(List<string> positionNameList, List<string> candidateNameList) {
        try {
            id poid_c;
            id caid_c;
            
            Integer poListSize;
            Integer caListSize;

            poListSize = positionNameList.size();
            caListSize = candidateNameList.size();

            Integer size;
    
            if(poListSize > caListSize){
                size = poListSize;
                for(Integer i = caListSize; i < poListSize; i++){
                    candidateNameList.add(null);
                }
            }else{
                size = caListSize;
                for(Integer i = poListSize; i < caListSize; i++){
                    positionNameList.add(null);
                }
            }

            List<Job_Application__c> listJob = new list<Job_Application__c>();
            List<Review__c> listRev = new list<Review__c>();

            Map<Id, candidate__c> canMap = new Map<Id, candidate__c>([select id,name from candidate__c]);
            Map<Id, position__c> poMap = new Map<Id, position__c>([select id,name from position__c]);
            // system.debug('canmap' + canMap);
            Set<ID>  canMap_keys = canMap.keyset();
            // System.debug('2' + canMap_keys);
            Set<ID> poMap_keys = poMap.keyset(); 
         
            for(Integer i = 0; i < size; i++){
                // System.debug(123);
                for(ID canId : canMap_keys){    
                    // System.debug('3' + canId);
                    if(canMap.get(canId).name == candidateNameList[i]){
                        caid_c = canId;
                        system.debug('candiateName is exsited');
                        break;
                    }
                }

                for(ID poId : poMap_keys){
                    if (poMap.get(poId).name == positionNameList[i]) {
                        poid_c = poId;
                        system.debug('positionName is exsited');
                        break;
                    }
                }

                
                job_application__c ja = new job_application__c();
                ja.position__c = poid_c;
                ja.candidate__c = caid_c;
                listJob.add(ja);
               
            }
            insert listJob;

            for (job_application__c ja : listJob) {
                review__c r = new review__c(Rating__c = 1,Job_Application__c = ja.id);
                listRev.add(r);
            }
 
            insert listRev;
            
            

        } catch (Exception e) {
            system.debug(e.getMessage());
        }

    }
}
