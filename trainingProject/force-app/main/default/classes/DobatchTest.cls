@istest
public class DobatchTest {
  @TestSetup
   static void setup(){
      addcontent.test1();
           }
@istest         
static void test2(){
         test.startTest();
         Dobatch d=new Dobatch();
         Database.executeBatch(d,1);
         test.stopTest();
           }
       }

