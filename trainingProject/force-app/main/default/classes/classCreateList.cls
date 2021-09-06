public with sharing class classCreateList {
    public static void classCreateList(list<string> positionName,list<string> candidateName) {
        map<id, candidate__c> canmap =new map<id, candidate__c>([select id,name from candidate__c ]) ;
        map<id, Position__c> posmap =new map<id, Position__c>([select id,name from Position__c ]) ;
        map<id, Job_Application__c> jmap =new map<id, Job_Application__c>([select id,candidate__R.name from Job_Application__c ]) ;

        id candidateID;
        id positionID;

        integer ca = candidateName.size();
        integer po = positionName.size();
        integer all;
        
        if (ca >= po) {
            all = ca;

            for(integer i = po; i < ca; i++){
                //integer sizebe = ca - po;
                positionName.add(null);
                }
            }else{
            for(integer i = ca; i < po; i++){
                //integer sizebe = po - ca;
                candidateName.add(null); 
                }
            all = po;
        }
        List<job_application__c> jo = new List<job_application__c>();
        List<review__c> re = new List<review__c>();

    try {
        for(integer i = 0; i < all; i++){
            integer flag = 1;
            for (id jidKey : jmap.keyset()) {
                Job_Application__c jTemp=jmap.get(jidKey);
                if(jTemp.candidate__r.name == candidatename[i]){
                    flag = 1;
                }
            for (id canidKey : canmap.keyset()) {
                candidate__C canTemp = canmap.get(canidKey);
                if(canTemp.name == candidatename[i]){
                    candidateID = canTemp.id;
                }
            }
            for (id posidKey : posmap.keyset()) {
                position__c posTemp = posmap.get(posidKey);
                if(posTemp.name == positionname[i]){
                    positionID = posTemp.id;
                }
            }
            if(flag == 1){
                Job_Application__c job = new Job_Application__c();
                job.Position__c = positionID;
                job.candidate__c = candidateID;
                jo.add(job);
            }else {
            throw new applicationException('存在');
        }
    }
        insert jo;
        if(jo.size()>0){
        for(job_application__c ja : jo){
            review__c theReview = new review__c(Rating__c = 1,Job_Application__c = ja.id);
            re.add(theReview);
            }
        }else {
            throw new applicationException('存在');
        }
        insert re;
    }
    }catch(applicationException e) {
        System.debug('Candiadatename is already exist!');
    }catch(DMLEXCEPTION E ){
        System.debug('Created faliure!');
        }
    }
}