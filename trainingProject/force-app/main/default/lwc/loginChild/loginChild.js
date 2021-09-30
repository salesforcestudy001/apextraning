/*
 * @Author: your name
 * @Date: 2021-09-30 11:13:43
 * @LastEditTime: 2021-09-30 13:15:36
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \trainingProject\force-app\main\default\lwc\loginChild\loginChild.js
 */
import { LightningElement ,api} from 'lwc';

export default class LoginChild extends LightningElement {
    @api
    returnUsername(){
        console.log("进来了returnUsername");
        // console.log(this.querySelector('.username').value);
        return this.querySelector('.username').value;
        // let userArray=this.querySelectorAll('lightning-input');
        // let name;
        // for (let index = 0; index < userArray.length; index++) {     
        //     if (userArray[index].label=='Username') {
        //         name=userArray[index].value;
        //     }          
        // }
        // return name;



        //return this.querySelector('lightning-input[label="username"]').value;

    }
    @api
    returnPassword(){
        console.log("进来了returnPassword");
         // console.log(this.querySelector('.password').value);
        return this.querySelector('.password').value;
        // let passwordArray=this.querySelectorAll('lightning-input');
        // let password;
        // for (let index = 0; index < passwordArray.length; index++) {     
        //     if (passwordArray[index].label=='Password') {
        //         password=passwordArray[index].value;
        //     }          
        // }

        //return this.querySelector('lightning-input[label="password"]').value;
    }
}