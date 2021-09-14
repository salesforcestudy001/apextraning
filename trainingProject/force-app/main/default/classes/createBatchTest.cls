public with sharing class createBatchTest implements Database.Batchable<sObject>,Database.stateful {

    list<id> successId=new list<id>();
    List<string> errorMessages = new List<string>();
    List<string> errorStatusCodes = new List<string>();
    public Database.QueryLocator start(Database.BatchableContext bc) {
      System.debug('**start begin');
      string sql='select id,phone from contact';
      System.debug('**start end');
      return Database.getQueryLocator(sql);
    }
    public void execute(Database.BatchableContext bc, List<contact> records){
        System.debug('**excute begin');
        for (contact c : records) {
            c.phone='86'+c.phone;
        }
        list<database.SaveResult> result=database.update(records,false);
        for (Database.SaveResult sr : result) {
            if (sr.isSuccess()) {
                successId.add( sr.getId());
            } else {
                for(Database.Error err : sr.getErrors()) {
                    errorMessages.add(err.getMessage());
                    errorStatusCodes.add(string.valueof(err.getStatusCode()));
             }
            }
        }
        System.debug('**excute end');
    }
    public void finish(Database.BatchableContext bc){
        System.debug('**finish begin');
        System.debug('The following record has successed.');
        for (id m : successId) {
            System.debug('Successfully updated contact. Contact ID: ' + m);
        }
        System.debug('The following error has occurred.');
        for (Integer i = 0; i < errorMessages.size(); i++) {
            System.debug(errorStatusCodes[i] + ': ' + errorMessages[i]);
        }
        System.debug('**finish end');
     /* for (Database.SaveResult sr : results) {
                if (sr.isSuccess()) {
                    System.debug('Successfully updated contact. Contact ID: ' + sr.getId());
                } else {
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Contact fields that affected this error: ' + err.getFields());
                }
                }
            } */
    }
}