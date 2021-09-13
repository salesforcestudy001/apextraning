public with sharing class JobApplicationTriggerHandler extends TriggerHandlerAdapter  {
    public static Boolean triggerDisabled = false;
    public override Boolean isDisabled() {
      return triggerDisabled;
    }
    //beforeinsert  trigger method
    public override  void beforeInsert(List<SObject> newItems) {
        Jobimplement.addApplicationBango((List<Job_Application__c>) newItems);
    }
    //afterInsert  trigger method
    public override  void afterInsert(Map<Id, SObject> newItems ) {
        Jobimplement.avgSalary((Map<Id, Job_Application__c>) newItems);
    }
    //afterUpdate  trigger method
    public override   void afterUpdate(Map<Id, SObject> newItems,Map<Id, SObject> oldItems) {
        Jobimplement.avgSalary((Map<Id, Job_Application__c>) newItems);
    }
    //beforeDelete  trigger method
    public override void afterDelete(Map<Id, SObject> oldItems) {
        Jobimplement.avgSalaryforDelete((Map<Id, Job_Application__c>) oldItems);
    }
    
}
