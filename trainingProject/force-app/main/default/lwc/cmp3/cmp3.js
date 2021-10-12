import { LightningElement } from 'lwc';

export default class Cmp3 extends LightningElement {
    handleSelect(event){
        let e=new CustomEvent('previous',{ bubbles:true,composed:true});
        this.dispatchEvent(e);
    }
}