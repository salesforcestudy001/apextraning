import { LightningElement,api} from 'lwc';
import TRAILHEAD_LOGO from '@salesforce/resourceUrl/loginpicture';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class MyLogin extends LightningElement {
   imgurl=TRAILHEAD_LOGO;
   @api recordId;
   objectApiName='userCui__c';
   temp=[];
//所有的输入check通过之后保存到数据库之后，跳转到另外一个画面，显示登录成功的信息。
logSuccess(){
        const Fields = this.template.querySelectorAll('lightning-input-field');
        if (Fields) {
            Fields.forEach(field => {
                this.temp[field.fieldName]=field.value;
            });
        }
        alert('Username：'+this.temp.Username__c+'\n'+'Role:'+this.temp.Role__c+'\n'+'报名成功!');

 }

 signSuccess(event){
    const Fields =new ShowToastEvent({
        title:"MY SALESFORCE",
        message:"Record Id"+event.detail.id,
        variant:"success"

   });
    this.dispatchEvent(Fields);
    window.open('https://login.salesforce.com/','_blank')
   }

errorMessage(event){
    console.log(event.detail);
    this.dispatchEvent(new ShowToastEvent({
        title:'错误信息，username重复，不能在注册了!',
        message:event.detail.message,
        variant:'error'

    }),
    );
    
}
}
