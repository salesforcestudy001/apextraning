import LastPasswordChangeDate from '@salesforce/schema/User.LastPasswordChangeDate';
import Username from '@salesforce/schema/User.Username';
import { LightningElement ,api} from 'lwc';

export default class Child extends LightningElement {
    @api
    login(){
        let username
        let password
        let messages = this.querySelectorAll('lightning-input');
        for(let i=0;i<messages.length;i++){
            if(messages[i].label =='username'){
                username = messages[i].value
            }
            if(messages[i].label == 'password'){
                password = messages[i].value
            }
        }
        alert('username:'+username+',password'+password)
    }
    @api
    f1(){
        
        console.log(222)
        alert(333)
        // console.log(this.querySelector('span'));
    }
}