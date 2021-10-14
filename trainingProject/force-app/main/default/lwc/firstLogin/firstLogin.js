/*
 * @Author: your name
 * @Date: 2021-10-14 14:11:46
 * @LastEditTime: 2021-10-14 16:43:40
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \trainingProject\force-app\main\default\lwc\firstLogin\firstLogin.js
 */
import { LightningElement ,wire} from 'lwc';
import SALESFORCE_LOGO from '@salesforce/resourceUrl/salesforce_logo';
import getRecords from '@salesforce/apex/userScyControl.getRecords'
export default class FirstLogin extends LightningElement {
    logo=SALESFORCE_LOGO;
    objectApiName='UserScy__c';
    temp=[];
    @wire (getRecords)Records;
    handleSave(){
        const inputField = this.template.querySelector('.username');
        if (Records) {
            for (let index = 0; index < Records.length; index++) {
                if (Records[index].Username__c=inputField.value) {
                    alert("重复的Username禁止注册");
                    inputField.reset();
                    break;
                }
                
            }
        }
    }
    handleSuccess(){
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                this.temp[field.fieldName]=field.value;
                field.reset();
            });
        }
        alert(this.temp.Username__c+'\n'+'登录成功');
    }
}