import { api, LightningElement } from 'lwc';

export default class Child001 extends LightningElement {
    @api
    
    // f1(){
    //     alert('child001.test');
    //     console.log(this.querySelector('span'));
    // }
    // handleSlotChange(){
    //     alert('handleSlotChange');
    // }
    
    returnvalue(){
        let username
        let password
        console.log("取用户名和密码");
        let messages=this.querySelectorAll('lightning-input');
    for(let i=0;i<messages.length;i++){
        if(messages[i].label =='username'){
            username = messages[i].value
        }
        if(messages[i].label == 'password'){
            password= messages[i].value
        }
    }
        
        
       // alert ('username'+messages[0].value+'password'+messages[1].value);
        alert('username:'+username+"\n"+'password'+password);
    }
    
}