import { LightningElement,api } from 'lwc';

export default class Child extends LightningElement {
    @api
    loginn(){
        let message = this.querySelectorAll('lightning-input')
        let name
        let password 
        for(let i = 0; i < message.length; i++){
            if(message[i].label == 'username'){
                name = message[i].value
            }
            if(message[i].label == 'password'){
                password = message[i].value
            }
        }
        alert('username:'+name+',password:'+password)
    }
}