public with sharing class testClass {
    public testClass() {    
    }
    public enum season{Winter,Spring,Summer,Fall}
    season southernHemisphereSeason = season.Winter;
    public season getsouthernHemisphereSeason(season northernHemisphereSeason){
        if (northernHemisphereSeason == Season.Summer) {
            return southernHemisphereSeason;
        }
    Integer i;
    String str;
    List<Integer> lets;
    Set<Double> sd;
    Map<key,value> mkv;

    Date d;
    d.addDays(2);//?空指针？
    }
    public class myCle{
        static final Integer int_count = 100;
        static final Integer int_count2;
        public static Integer calculate(){
            return 2+7;
        }
        static{
            int_count2 = calculate();
        }
    }
    List <Account> aa = [select id,name from account where name = 'Acme'];
    
    Contact c = new Contact(Account = 
    [select name from account where numberOfEmployess > 10 limit 1]);

    Integer i = [select count() from Contact where LastName = 'Name'];
    
    Integer j = 5*[select count() from Account];
}
