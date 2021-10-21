public with sharing class CandidatePageController {
 
    List<CandidateWrapper> categories {get;set;}
         
        //从查询定位符实例化StandardSetController
        public ApexPages.StandardSetController con {
            get{
                if (con == null) {
                    con = new ApexPages.StandardSetController(
                        Database.getQueryLocator([ select Candidate_Name__c, 
                                                          Candidate_Age__c, 
                                                          Candidate_Phone__c,
                                                          Candidate_Email__c,
                                                          Candidate_Education__c,
                                                          Candidate_City__c,
                                                          Candidate_SSN__c,
                                                          Candidate_Visa_Required__c 
                                                          from Candidate_Test__c
                        ])
                    );
         
                    //设置每页中的记录数
                    con.setPageSize(9);
                    }
                        return con ;
                }
                set;
            }
         
        //返回当前页集中sObjects的包装器对象列表
        public List<CandidateWrapper> getCategories() {
            categories = new List<CandidateWrapper>();
                for (Candidate_Test__c category1 : (List<Candidate_Test__c>)con.getRecords())
                     categories.add(new CandidateWrapper(category1));
         
                return categories;
            }
        
        //显示所选项目
        public PageReference process() {
            for (CandidateWrapper cw : categories) {
                if (cw.checked)
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,cw.candidatet.Name));
                }
                return null;
        }
         
        //指示在当前页设置之后是否有更多记录
        public Boolean hasNext{
            get{
                return con.getHasNext();
            }
            set;
        }
         
        //指示当前页集之前是否有更多记录
        public Boolean hasPrevious{
            get{
                return con.getHasPrevious();
            }
            set;
        }
         
        //返回当前页集的页码
        public Integer pageNumber{
            get{
                return con.getPageNumber();
            }
            set;
        }
         
        //返回记录的第一页
        public void first(){
            con.first();
        }
         
        //返回记录的最后一页
        public void last(){
            con.last();
        }
         
        //返回前一页的记录
        public void previous(){
            con.previous();
        }
         
        //返回下一页的记录
        public void next(){
            con.next();
        }
         
        //返回原始页面(如果已知)或主页的PageReference
        public void cancel(){
            con.cancel();
        }       
            
}
