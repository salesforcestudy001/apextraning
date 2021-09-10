/**
 *File Name     : JobApplicationTrigger
 *@description  : JobApplicationトリガ
 *Author        : zongkui.yang
 *CreatedDate   : 2021/9/9
 *UpdatedDate   :
 */
trigger JobApplicationTrigger on Job_Application__c(
  before insert,
  after insert,
  after update,
  after delete
) {
  // トリガのディスパッチャーを呼び出す
  TriggerDispatcher.Run(
    new JobApplicationTriggerHandler(),
    Trigger.operationType
  );
}