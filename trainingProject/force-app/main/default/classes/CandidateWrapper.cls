public with sharing class CandidateWrapper {   

    // Boolean的checked , 用来作为判断数据行是否被选的属性
    public Boolean checked{ get; set; }
    // Candidate 对象 , 用来获取Candidate Test的相关信息
    public Candidate_Test__c candidatet { get; set;}
        
        public CandidateWrapper(){
            candidatet = new Candidate_Test__c();
            checked = false;
        }
        
        public CandidateWrapper(Candidate_Test__c candidatet){
            this.candidatet = candidatet;
            checked = false;
        }

}
