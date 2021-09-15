public with sharing class FunctionRealization {

//＠Auther 綾地寧々

    public void BangoInsert(List<SObject> newItems){

        // 当Job_Application追加一条记录的时候，申請番号会自动採番、採番的格式是「A00000001」,
        // 比如如果数据库里已经存在11条Job_Application记录，再追加一条的时候申請番号的值应该是「A00000012」.
       
        

        integer JaCount = 1;

        List<Integer> Bangos = new List<Integer>();

        Integer MaxBango = 0;

        integer conutJob_Application = [select count() from Job_Application__c];

        List<Job_Application__c> Job_Applications_ApplicationBangos   = 
            [select  ApplicationBango__c from Job_Application__c];
        for (Job_Application__c JA : Job_Applications_ApplicationBangos) {  
            if(JA.ApplicationBango__c != null){
                Bangos.add(integer.valueOf(JA.ApplicationBango__c.subString(1)));
            }else {
                Bangos.add(0);
            }
           
        }
        //  すべての番号を取り出して　Bangosに挿入した

        for (Integer Bango : Bangos) {
            if(Bango > MaxBango){
                MaxBango = Bango;
            }
        }
        //  最大番号を選ぶ

        for (Job_Application__c ja : (List<Job_Application__c>)newItems) {
            if(MaxBango > conutJob_Application){
                // System.debug(putZero(MaxBango));
                ja.ApplicationBango__c =  putZero(MaxBango + JaCount);
            }else {
                // System.debug(putZero(MaxBango));
                ja.ApplicationBango__c = putZero(conutJob_Application + JaCount);
            }
            JaCount ++;
        }      
    }



    public void HeikinKibouKyuryou(){
        
       
        List<Job_Application__c> ExpectSalarys = [select ExpectSalary__c from Job_Application__c where ExpectSalary__c = null];
        for (Job_Application__c  ExpectSalary: ExpectSalarys) {
                ExpectSalary.ExpectSalary__c = 0;       
        }
        Update ExpectSalarys;
        
        List<Candidate__c> Candidates = [select ID,AverageSalary__c from Candidate__c];
        ID canId ;
        Double canAvg;
            for (Aggregateresult CanId_Avg  :  [select Candidate__r.id, AVG(Job_Application__c.ExpectSalary__c) canAvg from Job_Application__c where Candidate__r.id != null group by Candidate__r.id]) {
                canId = (ID)CanId_Avg.get('id');
                // System.debug(CanId_Avg.get('id'));
                canAvg = (Double)CanId_Avg.get('canAvg');
                // System.debug('canId   ' +  canId);
                // System.debug('canAvg   ' + canAvg);
                for (Candidate__c Candidate : Candidates) {
                    if (canId.equals(Candidate.id)) {
                        Candidate.AverageSalary__c = canAvg;
                        break;
                    }
                }
            }

            Update Candidates;

        }

    public String putZero(Integer original){
        String putZeroStr = '0000000' + original;
        if (putZeroStr.length() > 8) {
            putZeroStr = putZeroStr.subString(putZeroStr.length() - 8);
            return 'A' + putZeroStr;
        }else {
            return 'A' + putZeroStr;
        }

    }

}
