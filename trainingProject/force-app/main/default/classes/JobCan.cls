public with sharing class JobCan {

    // 用Trigger实现如下功能：
    // 当Job_Application追加一条记录的时候，申請番号会自动採番、採番的格式是「A00000001」,
    // 比如如果数据库里已经存在11条Job_Application记录，再追加一条的时候申請番号的值应该是「A00000012」.

    // 注意：
    // Trigger完成之后，请做一个包含500条Job_Application数据的CSV文件，用Dataloader导入到数据库中，检测Trigger的逻辑是否正确。
    // 请使用上午提供的Trigger框架。

    public static void JobBango(List<Job_Application__c> jobapList) {
        // System.debug(2);

        String ApplicationBango;
        List<Integer> bangoList = new List<Integer>();

        Integer count = [select count() from Job_Application__c];
        // Integer count = Integer.valueOf(countId);
        Integer bango = 0;




        List<Job_Application__c> JobList = [select ApplicationBango__c from Job_Application__c];

 
                bangoList.add(-1);

            for (Job_Application__c JobBango : JobList) {
                if (JobBango.ApplicationBango__c != null) {
                    bango = Integer.valueOf(JobBango.ApplicationBango__c.subString(1,9));
                    bangoList.add(bango);
                }

            }
            System.debug(bangoList);
            bangoList.sort();
            System.debug(bangoList.size()-1);
 
            Integer maxBango = bangoList[bangoList.size()-1];
                for (Integer i = 0; i<jobapList.size(); i++) {
                    String a = 'A';
                    if (count > maxBango) {
                        String n = String.valueOf(count+i+1);
                        ApplicationBango = a + n.leftpad(8,'0');
                    }else {
                        String n = String.valueOf(maxBango+i+1);
                        ApplicationBango = a + n.leftpad(8,'0');
                    }
                    jobapList[i].ApplicationBango__c = ApplicationBango;
                }
        }




    // 当Job_Application发生增删改的时候，根据Job_Application里的希望給料，算出改Candidate的所有的【平均希望給料】，
    // 保存到Candidate的平均希望給料里。

    public static void JobCanAvg(){

        List<Job_Application__c> expectSalaryList = [select id,ExpectSalary__c from Job_Application__c where ExpectSalary__c = null];
        for (Job_Application__c es : ExpectSalaryList) {
                es.ExpectSalary__c = 0;
        }
        Update expectSalaryList;       

        id canId;
        Double avgExs;

        List<candidate__c> canList = [select id,AverageSalary__c from candidate__c];

        for(Aggregateresult avgES : [select candidate__r.id, avg(ExpectSalary__c)avgEpSal from Job_Application__c where candidate__r.id != null group by candidate__r.id]){
                    avgExs = Double.valueOf(avgES.get('avgEpSal')); 
                    canId = (ID)avgES.get('id');
                    for (Candidate__c c : canList) {
                        if (c.id.equals(canId)) {
                            c.AverageSalary__c = avgExs;
                            break;
                        }
                    }
                }

                Update canList;
        
        
          

    }
}
