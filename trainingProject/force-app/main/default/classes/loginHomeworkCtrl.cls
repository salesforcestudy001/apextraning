public with sharing class loginHomeworkCtrl {
    @AuraEnabled(cacheable=true)
    public static List<UserZX__c> getUserList() {
        // for (List<UserZX__C>  users: [select ID,Name,First_Name__c,Last_Name__c,Company__c,Country__c,Email__c,Postal_Code__c,Role__c,	Username__c from USERZX__c]) {
        //     for(UserZX__c user : users){
        //         system.debug(user.Name);
        //     }
        // }
        return [select ID, 
                       Name, 
                       First_Name__c, 
                       Last_Name__c, 
                       Email__c, 
                       Roles__c, 
                       Company__c, 
                       Countries__c, 
                       Postal_Code__c, 
                       Username__c 
                       from USERZX__c];
    }

    @AuraEnabled()
    public static void insertuser(String firstname,String lastname,String company,String countries,String email, String postalcode, String roles,String username ) {
        USERZX__c uc = new USERZX__c(First_Name__c = firstname, 
                                     Last_Name__c = lastname, 
                                     Email__c = email, 
                                     Roles__c = roles, 
                                     Company__c = company, 
                                     Countries__c = countries,  
                                     Postal_Code__c = postalcode, 
                                     Username__c = username);
        insert uc;
        // system.debug(firstname);
        // system.debug(lastname);
        // system.debug(company);
        // system.debug(countries);
        // system.debug(email);
        // system.debug(postalcode);
        // system.debug(roles);
        // system.debug(username);
    }
}
