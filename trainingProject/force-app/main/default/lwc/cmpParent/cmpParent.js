
import LastName from '@salesforce/schema/Contact.LastName';
import { LightningElement } from 'lwc';

export default class CmpParent extends LightningElement {
    firstname;
    show=false;
    constructor() {
        super();
        this.firstname='aaaa';
        console.log('***CmpParent.constructor***');
    }
    connectedCallback(){
        throw new Error('Required');
        console.log('***CmpParent.connectedCallback***');
    }
    renderedCallback(){
        console.log('***CmpParent.renderedCallback***');
    }
    disconnectedCallback(){
        console.log('***CmpParent.disconnectedCallback***');
    }
    handleClick(){
        this.show=!this.show;
    }
}