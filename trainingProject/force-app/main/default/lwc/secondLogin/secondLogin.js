/*
 * @Author: your name
 * @Date: 2021-10-14 14:11:46
 * @LastEditTime: 2021-10-15 14:22:11
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \trainingProject\force-app\main\default\lwc\firstLogin\firstLogin.js
 */
import { LightningElement ,wire} from 'lwc';
import SALESFORCE_LOGO from '@salesforce/resourceUrl/salesforce_logo';
import getRecords from '@salesforce/apex/userScyControl.getRecords'
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class FirstLogin extends LightningElement {
        logo=SALESFORCE_LOGO;
        objectApiName='UserScy__c';
        temp=[];
        uid;
        name;
        email;
        role;
        company;
        country;
        postalcode;
        username;
        firstname;
        lastname;
        Records=[];
        get roleoptions(){
            return [{ label: 'Developer', value: 'Developer' },
                    { label: 'Architect/CTO', value: 'Architect/CTO' },
                    { label: 'Administtrator', value: 'Administrator' },
                    { label: 'IT Manager/Executive', value: 'IT Manager/Executive' },
                    { label: 'Business/Executive', value: 'Business/Executive' }];
        }
        @wire (getRecords)
        getuser({data}){
            if (data) {
                this.Records=this.Records.concat(data);
            }   
        }
        handlefirstname(event){
            event.target.setCustomValidity('');
            this.firstname=event.target.value;
            this.name=this.firstname+this.lastname;
        }
        handlelastname(event){
            event.target.setCustomValidity('');
            this.lastname=event.target.value; 
            this.name=this.firstname+this.lastname;    
        }
        handleemail(event){
            event.target.setCustomValidity('');
            this.email=event.target.value;
        }
        handlecompany(event){
            event.target.setCustomValidity('');
            this.company=event.target.value;          
        }
        handlecountry(event){
            event.target.setCustomValidity('');
            this.country=event.target.value;           
        }
        handleRole(event){
            event.target.setCustomValidity('');
            this.role=event.target.value;
        }
        handlepostalcode(event){
            event.target.setCustomValidity('');
            this.postalcode=event.target.value;
        }
        handleusername(event){
            event.target.setCustomValidity('');
            this.username=event.target.value;
        }

    handleSave(){
        //console.log(JSON.stringify(this.Records));
        const inputField = this.template.querySelector('.username');
        let emailrule=/^([0-9A-Za-z\-_\.]+)@([0-9A-Za-z]+\.[A-Za-z]{2,3}(\.[A-Za-z]{2})?)$/g;
        let usernamerule=/^([0-9A-Za-z\-_\.]+)@([0-9A-Za-z]+\.[A-Za-z]{2,3}(\.[A-Za-z]{2})?)$/g;
        if (this.Records) {
            for (let index = 0; index < this.Records.length; index++) {
                if (this.Records[index].Username__c==inputField.value) {
                    alert("重复的Username禁止注册");
                    return "重复的Username禁止注册";
                } 
            }
        }
        //console.log(this.email);
        if(!emailrule.exec(this.email)){
            alert("邮箱格式错误");
            return "邮箱格式错误";
        }
        if(!usernamerule.exec(this.username)){
            console.log(this.username);
            alert("用户名格式错误");
            return "用户名格式错误";
        }
        const fields = {Name:this.name,
                        Username__c:this.username,
                        Role__c:this.role,
                        Postal_Code__c:this.postalcode,
                        Last_Name__c:this.lastname,
                        Email__c:this.email,
                        Country__c:this.country,
                        Company__c:this.company,
                        First_Name__c:this.firstname};
        const recordInput = { apiName:'UserScy__c', fields };
        createRecord(recordInput)
        .then(response  => {
            //console.log(JSON.stringify(response));
            this.uid = response.id;
            const temprecord={Username__c:response.fields.Username__c.value,Id:response.id}
            this.Records.push(temprecord);
            //console.log(JSON.stringify(this.Records));
            const inputFields = this.template.querySelectorAll('lightning-input');
            const combofields =this.template.querySelectorAll('lightning-combobox');
            if (inputFields) {
                inputFields.forEach(field => {
                    this.temp[field.fieldName]=field.value;
                    field.value='';
                });
            }
            if (combofields) {
                combofields.forEach(field => {
                    this.temp[field.fieldName]=field.value;
                    field.value='';
                });
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'User '+response.fields.Username__c.value+' created',
                    variant: 'success',
                }),
            );
        })
        .catch(error => {
            //console.log(JSON.stringify(error.body));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
        });
    }
    handleinvalid(event){
        event.target.setCustomValidity('Enter Your '+event.target.label);
    }
}