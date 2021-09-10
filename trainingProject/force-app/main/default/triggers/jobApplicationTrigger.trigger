trigger jobApplicationTrigger on Job_Application__c (
    before insert,
    after insert,
    after update,
    after delete
){
    TriggerDispatcher.Run(
    new jobApplicationTriggerHandler(),
    Trigger.operationType
  );  
   
}