trigger helloWorld on Contact (before delete, before insert, before update, 
after delete, after insert, after update, after undelete) {

    if (trigger.isupdate) {
        if (trigger.isbefore ) {
            system.debug('hello world trigger isbefore update');
        }else if (trigger.isafter){
            system.debug('hello world trigger isafter update');
        }
    }
}