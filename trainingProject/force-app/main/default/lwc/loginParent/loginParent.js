/*
 * @Author: your name
 * @Date: 2021-09-30 11:13:55
 * @LastEditTime: 2021-09-30 13:38:48
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \trainingProject\force-app\main\default\lwc\loginParent\loginParent.js
 */
import { LightningElement } from 'lwc';

export default class LoginParent extends LightningElement {
    clickHandler(){
        console.log("进来了clickHandler");
        let userNameRule=/^[a-zA-Z][a-zA-Z0-9_]{4,15}$/;
        let passwordRule=/^[a-zA-Z0-9]{4,15}$/;
        let loginC=this.template.querySelector('c-login-child');
        if(userNameRule.test(loginC.returnUsername())==false||passwordRule.test(loginC.returnPassword())==false){
            alert("Wrong Username or Password Format");
        }else{
            alert("Username = "+loginC.returnUsername()+"\n"+"Password = "+loginC.returnPassword()+"\n"+"Login Successfully!");
        }
    }
}