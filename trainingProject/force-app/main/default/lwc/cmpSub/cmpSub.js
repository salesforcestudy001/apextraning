import { LightningElement,api } from 'lwc';

export default class CmpSub extends LightningElement {
    @api
    lastname;
    constructor() {
        super();
        console.log('***CmpSub.constructor***');
        console.log('***CmpSub.constructor***'+this.lastname);
    }
    connectedCallback(){
        console.log('***CmpSub.connectedCallback***');
        console.log('***CmpSub.connectedCallback***'+this.lastname);
    }
    renderedCallback(){
        console.log('***CmpSub.renderedCallback***');
    }
    disconnectedCallback(){
        console.log('***CmpSub.disconnectedCallback***');
    }
}