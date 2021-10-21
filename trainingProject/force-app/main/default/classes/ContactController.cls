public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(String searchtext) {
        
        return [
            SELECT Id, Name, Title, Phone, Email
            FROM Contact
            where name=:'searchName'
        ];
    }
}
