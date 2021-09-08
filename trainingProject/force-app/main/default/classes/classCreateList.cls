public class classCreateList {
    public void createJobApplication(List<string> positionNames,List<string> candidateNames){
        try{
            // candidate情报取得
            List<Candidate__c> candidates = [select id, name from Candidate__c where name in :candidateNames];
            // position情报取得
            List<Position__c> positions = [select id, name from Position__c where name in :positionNames];
            // Job_Application情报取得
            List<Job_Application__c> JobApplications = [select id,Candidate__r.name from Job_Application__c where Candidate__r.name in :candidateNames];
            
            // 取两个数组中元素多的作为循环的总次数
            integer num = 0;
            if(positionNames.size() >= candidateNames.size()){
                num = positionNames.size();
            }else{
                num = candidateNames.size();
            }
            //②、创建job Application
            List<Job_Application__c> listJA = new List<Job_Application__c>();
            Integer flag = 1;
            for(integer i=0;i<num;i++){
                Job_Application__c job = new Job_Application__c();
                if( i < candidateNames.size()){
                    // ①、业务check，当candidateName已经存在于job_application中的时候，用system.debug提示错误信息
                    for(Job_Application__c jobApplica : JobApplications){
                        if(candidateNames[i] == jobApplica.Candidate__r.name){
                            System.debug('用户:(' + candidateNames[i] +')信息已存在');
                            flag = 0;
                        }
                    }
                    // CandidateID写入
                    if(flag == 1){
                        for(Candidate__c candidate : candidates){
                            if(candidate.name == candidateNames[i]){
                               job.Candidate__c =candidate.id;
                               break; 
                            }
                        }
                    }
                }
                // PositionID写入
                if(i < positionNames.size()){
                    for(Position__c position : positions){
                        if(position.name == positionNames[i]){
                            job.Position__c = position.id;
                            break;
                        }
                    }
                }
                listJA.add(job);
                //flag还原
                flag = 1;
            }
            insert listJA;
            //③、创建review
            List<Review__c> listReview = new List<Review__c>();
            for(Job_Application__c jobApp : listJA){
                Review__c review = new Review__c();
                review.Job_Application__c = jobApp.id;
                review.Rating__c = 1;
                listReview.add(review);
            }
            insert listReview;  
        }catch (Exception e){
            //④、如果创建过程中出现错误，请打出错误信息
            throw new applicationException('创建有误');
        }
    }
}