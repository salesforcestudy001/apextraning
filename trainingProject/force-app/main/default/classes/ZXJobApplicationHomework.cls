
public with sharing class ZXJobApplicationHomework {
    //当Job_Application追加一条记录的时候，申請番号会自动採番、採番的格式是「A00000001」,
    //比如如果数据库里已经存在11条Job_Application记录，再追加一条的时候申請番号的值应该是「A00000012」.
    //番号
    public void BanGo(SObject[] newItems){

        integer count = [select count() from job_application__c];  
        //System.debug(count);
        List<job_application__c> newItemsLst = (List<job_application__c>) newItems;
        List<job_application__c> jo = [select  ApplicationBango__c from job_application__c];

        String max = '' ;

        for (job_application__c ja : jo) {
        if(ja.ApplicationBango__c > max && ja.ApplicationBango__c!=null)
            max = ja.ApplicationBango__c;  
        }
        if (max == '') {
            max = 'A00000000';
        }

        String no = max.substring(2);
        integer max1 = Integer.valueOf( max.substring(2));
        List<String> ni = new  List<String>();
        String subString;

        for (integer j = 0; j < newItemsLst.size(); j++) {
        if (count > max1) {
            integer newno = count+ 1 + j;
            String newnostr = string.valueOf(newno).leftPad(8,'0');
            subString = 'A' + newnostr;
        }else {
            integer newno = max1 + 1 + j;
            String newnostr = string.valueOf(newno).leftPad(8,'0');
            subString = 'A' + newnostr;
        }
        
        ni.add(subString);
        }

        for (integer i = 0; i < newItemsLst.size(); i++ ) {
            newItemsLst[i].ApplicationBango__c = ni[i];
        } 
    }
     
    // 当Job_Application发生增删改的时候，根据Job_Application里的希望給料，
    // 算出该Candidate的所有的【平均希望給料】，保存到Candidate的平均希望給料里。
    public void inupde( ){

    List<job_application__c> jaslist = [select  ExpectSalary__c from job_application__c 
        where ExpectSalary__c = null];

    for (job_application__c ja : jaslist) {
        ja.ExpectSalary__c = 0;
    }
    update jaslist;

    ID canid;
    Double AVGesc;

    List<candidate__c> canslist = [select  id,AverageSalary__c from candidate__c];
       
        for (Aggregateresult  resultSet:  [ select candidate__r.id, AVG(ExpectSalary__c)  AVGes 
            from job_application__c where candidate__r.id != null group by candidate__r.id ]) {
            canid = (Id)resultSet.get('id');
            AVGesc = (Double)resultSet.get('AVGes');
            for (candidate__c can : canslist) {
                if (canid.equals(can.id)) {
                    can.AverageSalary__c = AVGesc;
                    break;
                }
            }
        }
        update canslist;
    }
}
