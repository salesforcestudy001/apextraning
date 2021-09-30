import { LightningElement,api } from 'lwc';

export default class Child002 extends LightningElement {
    @api 
    fi(){
        let message=this.querySelectorAll('lightning-input');
        alert('username'+message[0].value+'passsword'+message[1].value);

    }

}