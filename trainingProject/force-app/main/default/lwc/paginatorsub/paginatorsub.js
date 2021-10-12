import { LightningElement,track } from 'lwc';

export default class Paginatorsub extends LightningElement {
    
    @track 
    theContact={
        Id: 1,
        Name: 'Amy Taylor',
        Title: 'VP of Engineering',
    };
    clickHandler(){
        let e=new CustomEvent('previous',{ detail: this.theContact });
        this.dispatchEvent(e);
    }
}