import { LightningElement } from 'lwc';

export default class CmpParent extends LightningElement 
{
    firstname;
    show=false;
    constructor() {
        super();
        this.firstname='aaaa';
        console.log('**CmpParent.constructor');
        
    }
    connectedCallback()
    {
        console.log('**CmpParent.connectedCallback');
    }
    renderedCallback()
    {
        console.log('**CmpParent.renderedCallback');
    }
    handleClick()
    {
        this.show=!this.show;
    }
}