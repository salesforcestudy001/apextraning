import { LightningElement } from 'lwc';

export default class CmpSub extends LightningElement {
    constructor() {
        super();
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
}