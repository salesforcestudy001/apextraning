import { LightningElement,wire } from 'lwc';
import getUserList from '@salesforce/apex/LoginHomework.getUserList';
import insertYuzi from '@salesforce/apex/LoginHomework.insertYuzi';
import getPickList from '@salesforce/apex/LoginHomework.getPickList';

export default class login extends LightningElement {

    @wire(getUserList) users;
    @wire(getPickList,{fld: "Country__c"}) pickList;
    Country = "None";
    Email = "";
    UserName = "";
    showRe = false;
    showLo = false;
    show = true;
    errorEmpty;
  
    // 注册按钮点击事件
    registerYuzi(){
        // console.log("login!!!");
        this.errorEmpty = this.JudgedEmpty();
        console.log(this.errorEmpty);
        if(this.errorEmpty != "true"){
            alert(this.errorEmpty + " is Empty!!");
        }else{
            if(this.Country == "None"){
                alert("CountryEmpty");
            }else{
                if(!this.checkUserName()){
                    alert("existUserName!!");
                }else{
                    if(!this.checkEmail()){
                        alert("invalidEmailAddress");
                    }else{
                        this.insertData();
                        console.log("Successed Register");
                        this.showRe = false;
                        this.show = true;
                        window.location.reload();
                    }
                }
                    
            }
        }
    }

    // 判断是否为空
    JudgedEmpty(){
        // console.log("JudgedEmpty!!!");
        let inputs = this.template.querySelectorAll('lightning-input');
            console.log("UserName: " + inputs[0].value);
            this.UserName = inputs[0].value;
            console.log("Email: " + inputs[1].value);
            this.Email = inputs[1].value;
        if(this.UserName == ""){
            // console.log("Empty!!");
            return "UserName";
        }else if(this.Email == ""){
            return "Email";
        }
        return "true";
    }

    // 检查用户名是否存在
    checkUserName(){
        // console.log("checkUserName");
        let inputs = this.template.querySelectorAll('lightning-input');

            // console.log("inputName: " + inputs[0].value);
            for (let i = 0; i < this.users.data.length; i++) {
                // console.log(this.users.data[i].User_Name__c);
                if(inputs[0].value == this.users.data[i].User_Name__c){
                    // console.log("exist!!");
                    return false;
                }
            }

        return true;
    }

    // 检查邮件格式
    checkEmail(){
        let inputs = this.template.querySelectorAll('lightning-input');
        let emailAdd = inputs[1].value;
        // console.log("Email:  " + emailAdd);
        if(emailAdd.includes(".com") && emailAdd.includes("@")){
            // console.log("Email:  " + emailAdd);
            return true;
        }else{
            return false;
        }
    }

    // 下拉列表赋值
    getFields(){
        let Fields = [];
        let data = this.pickList.data;
        for (let i = 0; i < data.length; i++) {
           let json = {label: data[i],value: data[i]};
            Fields.push(json);
        }
        console.log(this.Fields);
        let pl = this.template.querySelectorAll('lightning-combobox');
        pl[0].options = Fields;

    }

    // 获取国家值
    getCountry(con){
        this.Country = con.detail.value
    }

    // 向数据库中插入数据
    insertData(){
        console.log("StartInsert");
        // console.log("UserName: " + this.UserName);
        // console.log("Email: " + this.Email);
        // console.log("Country: " + this.Country);


        insertYuzi({ UserName: this.UserName,Email: this.Email,Country: this.Country })
         
    }

    // 登录
    logintoYuzi(){
        // console.log("Login!!");
        if(!this.CheckLoginUserName()){
            alert("用户名不存在！！");
        }else{
            if(!this.CheckLoginEmail()){
                alert("邮箱不正确！！");
            }else{
                alert("登录成功！！");
                this.showLo = false;
                this.show = true;
            }
        }

    }

    // 登录时检查用户名
    CheckLoginUserName(){
        // console.log("CheckName!!");
        let inputs = this.template.querySelectorAll('lightning-input');
        // console.log(inputs[0].value);
        for (let i = 0; i < this.users.data.length; i++) {
            if(inputs[0].value == this.users.data[i].User_Name__c){
                return true;
            }
        }

        return false;
    }
    // 登录时检查邮箱
    CheckLoginEmail(){
        console.log("CheckEmail!!");
        let inputs = this.template.querySelectorAll('lightning-input');
        console.log(inputs[1].value);
        for (let i = 0; i < this.users.data.length; i++) {
            if(inputs[1].value == this.users.data[i].Email__c){
                return true;
            }
        }

        return false;
    }

    Re(){
        this.show = !this.show;
        this.showRe = !this.showRe;
        this.showLo = false;
    }
    Lo(){
        this.show = !this.show;
        this.showLo = !this.showLo;
        this.showRe = false;
    }

}