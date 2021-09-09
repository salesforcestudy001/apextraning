trigger anotherTest on Contact (before insert,before update ) {
    system.debug('***anotherTest is begin**');
    myTest mT=NEW myTest();
    TriggerDispatcher.run(mT, trigger.operationType);
}