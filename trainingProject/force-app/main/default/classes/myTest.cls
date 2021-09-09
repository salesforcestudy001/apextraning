public without sharing class myTest extends TriggerHandlerAdapter{
    public static Boolean triggerDisabled=false;
    public override Boolean isDisabled(){
        return triggerDisabled;
    }
    public override void beforeInsert(List<SObject> newItems) {
        system.debug('****beforeInsert');
        checkphone((List<Contact>) newItems);
    }
    public override void beforeUpdate(Map<Id, SObject> newItems,Map<Id, SObject> oldItems) {
        system.debug('****before update');
        checkphoneforupdate((map<id,Contact>) newItems);
    }

    public void checkphone(List<Contact> contacts){
        for (Integer i = 0; i < contacts.size(); i++) {
            if(contacts[i].phone=='110'){
                contacts[i].phone='119';
            }
            if (contacts[i].phone=='112') {
                trigger.new[i].addError('错误的电话号码');
            }
        }
    }
    public void checkphoneforupdate(map<id,Contact> contacts){
        for (id contactTemp:contacts.keySet()) {
            if(contacts.get(contactTemp).phone=='110'){
                contacts.get(contactTemp).phone='119';
            }
            if (contacts.get(contactTemp).phone=='112') {
                contacts.get(contactTemp).addError('错误的电话号码');
            }
        }
    }

          
}
