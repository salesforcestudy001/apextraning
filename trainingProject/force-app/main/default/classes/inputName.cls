public with sharing class inputName {
    @AuraEnabled
    public static List<Candidate__c> inputName(string selectName ) {
        return[
            select id,name,allName__c,age__c,first_name__c,last_name__c,phone__c,email__c,education__c from candidate__c 
             where allName__c like : '%'+ selectName+'%' limit 3 
        ];
    }
    @AuraEnabled
    public static List<Candidate__c> deleteName(list<Candidate__c> Ids) {
        System.debug(Ids);
        if(Ids.size() > 0){
            System.debug('DeleteID: ' + Ids);
            List<Candidate__c> canList  = new List<Candidate__c>();
            for(integer i = 0; i < Ids.size(); i++){
                candidate__c c = new candidate__c(Id = Ids[i].Id);
                canList.add(c);
            }
           delete canList;
        }    
       return[
        select id,name,allName__c,age__c,first_name__c,last_name__c,phone__c,email__c,education__c from candidate__c 
        where allName__c like : '%'+''+'%' limit 3 
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Candidate__c> getCandidate(){
        return[
        select id,name,allName__c,age__c,first_name__c,last_name__c,phone__c,email__c,education__c from candidate__c 
        where allName__c like : '%'+''+'%' limit 3 offset 0
        ];
    }

    //翻页
    @AuraEnabled
    public static List<Candidate__c> getPageRows(integer page, string selectName ){
        // System.debug('Page: ' + page);
        // System.debug('Name: ' + selectName);
        return[
        select id, name,allName__c,age__c,first_name__c,last_name__c,phone__c,email__c,education__c from candidate__c 
        where allName__c like : '%'+selectName+'%' limit 3 offset :page
        ];
    }

    //总长度
    @AuraEnabled(cacheable=true)
    public static Integer rowsCount(string r,string selectName){
        System.debug('Page: ' + selectName);
        System.debug('count');
        AggregateResult allCounts = [select count(id) ids from candidate__c where allName__c like : '%'+selectName+'%' ]; 
        return (Integer)(allCounts.get('ids'));
    }
}
