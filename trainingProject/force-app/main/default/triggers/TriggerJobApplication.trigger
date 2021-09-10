trigger TriggerJobApplication on job_application__c (before Insert, after Insert, after Update, after Delete) {
    // System.debug('tr1s');
    TriggerDispatcher.Run(
        new JobApplicationTriggerHandler(),
        Trigger.operationType
        );
}