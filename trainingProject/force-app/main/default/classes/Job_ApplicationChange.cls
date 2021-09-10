public with sharing class Job_ApplicationChange extends TriggerHandlerAdapter{
    
    FunctionRealization fr = new FunctionRealization();
    public override void beforeInsert(List<SObject> newItems) {
        Integer i = 0;
       for (Job_Application__c ja : (List<Job_Application__c>)newItems) {
           ja.ApplicationBango__c = fr.BangoInsert(i);
           i ++;
       } 
    }


    public override void afterDelete(Map<Id, SObject> oldItems){
        fr.HeikinKibouKyuryou();
    }

    public override void afterInsert(Map<Id, SObject> newItems){
        fr.HeikinKibouKyuryou();
    }

    public override void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){
        fr.HeikinKibouKyuryou();
    }
}
