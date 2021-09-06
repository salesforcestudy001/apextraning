public with sharing class classCreate1 {
            public static void classCreateList(list<string> positionName,list<string> candidateName) {
                //new list->Job_Application__c、REVIEW__C
                List<Job_Application__c> JOBS = new List<Job_Application__c>();
                List<REVIEW__C> REVIEWS = new List<REVIEW__C>();
                /*id candidateID;
                id positionID;*/
                //map
                Map<ID, candidate__c> canMap =new Map<ID, candidate__c>([SELECT ID,NAME FROM candidate__c where  name in :candidateName ]) ;
                Map<ID, Position__c> posMap =new Map<ID, Position__c>([SELECT ID,NAME FROM Position__c where name in :candidateName]) ;
                Map<ID, Job_Application__c> jacMap =new Map<ID, Job_Application__c>([SELECT ID,candidate__R.NAME FROM Job_Application__c where candidate__R.NAME in :candidateName]) ;
                /*integer ca = candidateName.size();
                integer po = positionName.size();
                integer all;*/
                //使两个字符串列表具有相同的大小
                IF(positionName.size()>=candidateName.size()){
                    INTEGER sizes=positionName.size()-candidateName.size();
                    for (integer i=0 ;i< sizes;i++) {
                        candidateName.add(null);
                    }

                }else {
                    INTEGER sizes=candidateName.size()-positionName.size();
                    for (integer i=0 ;i< sizes;i++) {
                        positionName.add(null);
                    }
                }

                try {
                    for (integer i=0 ;i< candidateName.size();i++) {
                        //在job_application中查找candidateName
                        integer flag=0;
                        //id:candidate、position
                        id canid;
                        id posid;
                        //如果具有相同的candidateName，则设置flag=1
                        for (ID jaidKey : jacMap.keyset()) {
                            Job_Application__c jaTemp=jacMap.get(jaidKey);
                            if(jaTemp.candidate__R.NAME==candidateName[i]){
                                flag=1;
                            }
                        }
                        // 如果具有相同的candidateName，则设置id
                        for (ID canidKey : canMap.keyset()) {
                            candidate__C canTemp = canMap.get(canidKey);
                            if(canTemp.NAME==candidateName[i]){
                                canid=canTemp.id;
                            }
                        }
                         //如果具有相同的positionName，则设置id
                        for (ID posidKey : posMap.keyset()) {
                            position__C posTemp = posMap.get(posidKey);
                            if(posTemp.NAME==positionName[i]){
                                posid=posTemp.id;
                                break;
                            }
                        }
                        //flag==0 status create job_application else throw exception
                        IF(flag==0){
                            Job_Application__c JOB=new Job_Application__c();
                            JOB.Position__c=posid;
                            JOB.candidate__C=canid;
                            JOBS.add(JOB) ;
                        }else {
                        throw new createexception('存在');
                    }
                }
                insert JOBS;
                //if jobs not null ,create realated review,else throw exception
                if(JOBS.size()>0){
                    for (Job_Application__c jac : JOBS) {
                        REVIEW__C RE =new REVIEW__C(Job_Application__c=jac.ID,Rating__c=1);
                        REVIEWS.add(RE);
                    }
                }else {
                    throw new createexception('存在');
                }
                insert REVIEWS;
            } catch (createexception e){
                System.debug('candiadatename is already exist');
                 
             }catch(DMLEXCEPTION E ){
                 System.debug('CREATED FAILURE');
                 }
     
     }
     }
     
              /*  if (ca >= po) {
                    all = ca;
         
                   for(integer i = po; i < ca; i++){
                        positionName.add(null);
                        }
                    }else{
                    for(integer i = ca; i < po; i++){
                        candidateName.add(null); 
                        }
                    all = po;
                }
                List<job_application__c> jo = new List<job_application__c>();
                List<review__c> re = new List<review__c>();
         
                for(integer i = 0; i < all; i++){
                    for(candidate__c candidate : [select id,name from candidate__c where name = : candidateName[i]]){
                    candidateID = candidate.id;
                    break;
                    }
                for(position__c position : [select id,name from position__c where name = : positionName[i]]){
                    positionID = position.id;
                    break;
                    }
         
                    job_application__c thejobapplication = new job_application__c();
                    theJobapplication.position__c = positionID;
                    theJobapplication.Candidate__c = candidateID;
                    jo.add(thejobapplication);
         
                }
         
                insert jo;
         
                for(job_application__c ja : jo){
                    review__c theReview = new review__c(Rating__c = 1,Job_Application__c = ja.id);
                    re.add(theReview);
                    }
                insert re;
            }
        }*/

    

