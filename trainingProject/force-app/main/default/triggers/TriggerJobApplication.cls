trigger TriggerJobApplication on job_application__c (before insert,before update,
before delete,after insert,after update,after delete) {
    TriggerDispatcher.Run(
        new JobApplicationTriggerHandler(),
        Trigger.operationType
        );
}
