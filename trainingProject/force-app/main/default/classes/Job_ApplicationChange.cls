public with sharing class Job_ApplicationChange extends TriggerHandlerAdapter{
    
    FunctionRealization fr = new FunctionRealization();
    public override void beforeInsert(List<SObject> newItems) {
        fr.BangoInsert(newItems);
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
