public with sharing class JobApplicationTriggerHandler extends TriggerHandlerAdapter{
    public static Boolean triggerDisabled = false;
    public override Boolean isDisabled(){
        return triggerDisabled;
    }
    public override void beforeInsert(SObject[] newItems) {
        JobCan.JobBango((List<Job_Application__c>)newItems);
    }

    public override void afterInsert(Map<Id, SObject> newItems) {
        JobCan.JobCanAvg((Map<Id, Job_Application__c>)newItems);       
    }

    public override void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        JobCan.JobCanAvg((Map<Id, Job_Application__c>)newItems);       
    }

    public override void afterDelete(Map<Id, SObject> newItems) {
        JobCan.JobCanAvg((Map<Id, Job_Application__c>)newItems);       
    }





}