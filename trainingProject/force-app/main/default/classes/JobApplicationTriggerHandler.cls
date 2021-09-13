public with sharing class JobApplicationTriggerHandler extends TriggerHandlerAdapter{
    public static Boolean triggerDisabled = false;
    public override Boolean isDisabled(){
        return triggerDisabled;
    }
    
    ZXJobApplicationHomework zx = new ZXJobApplicationHomework();
    
    public override void beforeInsert(SObject[] newItems) {     
      zx.BanGo(newItems);
    }

    public override void afterInsert(Map<Id, SObject> newItems) {
      zx.inupde();
     }

    public override void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
      zx.inupde();
    }

    public override void afterDelete(Map<Id, SObject> oldItems) {
      zx.inupde();
     }
}