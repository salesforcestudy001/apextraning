public with sharing class contactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactlist(String getText){
     return [
         select Id,Name,Title,Phone,Email from Contact
         Where name=:'getName'
     ];
    }
}
