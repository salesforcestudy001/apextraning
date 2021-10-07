import JigsawContactId from "@salesforce/schema/Contact.JigsawContactId";

const change=()=>{
  
    var str = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
    function generateMixed(n) {
       var res = "";
       for(var i = 0; i < n ; i ++) {
         var name = Math.ceil(Math.random()*35);
         res += str[name];
       }
       return res;
    }
    var idd= Math.floor(Math.random()*100+1);
    var namee=generateMixed(6);
    var phonee = Math.floor(Math.random()*100000000+1);
    var emailArray = ['@qq.com','@163.com','@accenture.com'];
    var i = parseInt(3 * Math.random())
    var emaill=generateMixed(6)+emailArray[i];
    var addRecord=[{id:idd,name:namee,phone:phonee,email:emaill}];
    return addRecord;
}
export { change };