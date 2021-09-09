trigger helloWorld on Contact (before insert,before update,after update) {
    if(trigger.isUpdate){
        if(trigger.isBefore){
            System.debug('helloword trigger is before update');
        }else if(trigger.isAfter){
            System.debug('helloword trigger is after update');
        }
    }
}