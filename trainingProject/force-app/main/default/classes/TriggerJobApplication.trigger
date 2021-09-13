trigger TriggerJobApplication on job_application__c (before insert,after update ,after delete,after insert) {
    TriggerDispatcher.Run(
        new JobApplicationTriggerHandler(),
        Trigger.operationType
        );
}