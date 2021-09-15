trigger JobApplicationcTriggers on Job_Application__c (before delete, before insert, before update, 
after delete, after insert, after update, after undelete) {
    JobApplicationTriggerHandler Jath=new JobApplicationTriggerHandler();
    TriggerDispatcher.run(Jath, trigger.operationType);
}