trigger helloworld on Contact (before insert,before update,after update) {
    if(trigger.isUpdate){
        if (trigger.isBefore) {
            System.debug('helloworld trigger is before update');
        }
        else if (trigger.isAfter) {
            System.debug('helloworld trigger is after update');
        }
            
        }    
        }
    
