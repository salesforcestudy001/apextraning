public with sharing class JobApplicationTriggerHandler extends TriggerHandlerAdapter{
    public static Boolean triggerDisabled = false;
    public override Boolean isDisabled(){
        return triggerDisabled;
    }
    
    public override void beforeInsert(SObject[] newItems) { 

        list <job_application__c> newItemsLst = (list <job_application__c>)newItems; 
        list <job_application__c> jobApplicationLst = [select  ApplicationBango__c from job_application__c];
        String max = '' ;
        //取出最大的番号
        for(job_application__c job : jobApplicationLst){
            if(job.ApplicationBango__c > max && job.ApplicationBango__c!=null)
            max = job.ApplicationBango__c;     
        }
        //如果为空 赋为0
        if(max == ''){
            max = 'A00000000';
        }
        String numString = max.substring(2);//去掉A
        integer maxA = Integer.valueOf( numString); //转成integer
        integer newBan = maxA+1;

        integer newItemsLength = newItems.size();//newItems的长度
        list<String>  newItemsBangos = new list<String>();

        for(integer j = 0; j < newItemsLength; j++){     
            string newBanStr = String.valueOf(newBan+j);
            integer len = newBanStr.length();
            string subString =  '0';
            for(integer i = len; newBanStr.length() < 8; i++){
                subString = '0' + newBanStr;
                newBanStr = subString;
            }
            subString = 'A'+subString;
            newItemsBangos.add(subString);
            system.debug(subString);
        }
        for(integer i = 0; i < newItems.size(); i++){
            newItemsLst[i].ApplicationBango__c = newItemsBangos[i];
        }
    }

    public override void afterUpdate(Map<Id, SObject> newItems,Map<Id, SObject> oldItems) {
        JobApplicationTriggerHandler.dml(newItems);
     }

     public override void afterDelete(Map<Id, SObject> oldItems) {
        JobApplicationTriggerHandler.dml(oldItems);
    }

    public override void afterInsert(Map<Id, SObject> newItems) {
        JobApplicationTriggerHandler.dml(newItems);
    }

    //增删改方法
    public static void dml(Map<Id, SObject> items){
        //类型强制转换
        Map<ID,job_Application__c> itemsMap = (Map<ID,job_Application__c>) items;
        
        list<job_Application__c> jobApplicationList= itemsMap.values();
        List<Id> canIds = new List<Id>(); 
        for(job_Application__c job : jobApplicationList){
            canIds.add(job.candidate__c); //处理过的candidate的id
        }
        
        List<Job_Application__c> jas = [select candidate__c,ExpectSalary__c,candidate__r.AverageSalary__c from job_application__c where candidate__r.id != null];
        List<Candidate__c> cans = [select AverageSalary__c from candidate__c where id != null]; 

        for(Id ids:canIds){
            if(ids != null){//当candidate的id不为空时
                double avg = 0;
                double sum = 0;
                integer count = 0;
                for(job_application__c jobapp: jas){
                    if(ids.equals(jobapp.candidate__c)){
                        count++;
                        if(jobapp.ExpectSalary__c == null){
                            sum = sum + 0;
                        }else {
                            sum = sum + jobapp.ExpectSalary__c;
                        }
                        avg = sum/count;
                        for(candidate__c c : cans){
                            if(c.id.equals(ids)){
                                c.AverageSalary__c = avg;
                            }
                        }
                     } 
                }
                if(count == 0){ //如果数据表中没有数据 平均值为0
                    for(candidate__c c : cans){
                        if(c.id.equals(ids)){
                            c.AverageSalary__c = 0;
                        }
                    }
                }
                update cans;
            }
            
         }
           
    }
}