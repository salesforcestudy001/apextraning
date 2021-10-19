import { LightningElement, wire } from 'lwc';
import SALESFORCELOGO from '@salesforce/resourceUrl/SalesforceLogo';
//import getUserName from '@salesforce/apex/userLogin.getUserName'; 
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class SalesforceLogin extends LightningElement {
    photo=SALESFORCELOGO;
    ObjectApiName='userLogin__c';
    temp=[];

    handleClick(){
        const Fields = this.template.querySelectorAll('lightning-input-field');
        if (Fields) {
            Fields.forEach(field => {
                this.temp[field.fieldName]=field.value;
            });
            alert('Username：'+this.temp.Username__c+'\n'+'Role:'+this.temp.Role__c+'\n'+'请填充信息!');
        }else{
            alert('Username：'+this.temp.Username__c+'\n'+'Role:'+this.temp.Role__c+'\n'+'注册成功!');
        }
}

    handleSuccess(event){
        const Fields =new ShowToastEvent({
            title:"MY SALESFORCE",
            message:"Record Id"+event.detail.id,
            variant:"success"

    });
        this.dispatchEvent(Fields);
        window.open('https://login.salesforce.com/','_blank')
    }

    handleError(event){
        console.log(event.detail);
        this.dispatchEvent(new ShowToastEvent({
            title:'错误信息，username重复，不能在注册了!',
            message:event.detail.message,
            variant:'error'
        }),
    )}
}