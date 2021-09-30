import { LightningElement } from 'lwc';

export default class Parent002 extends LightningElement {
    handleClick(){
        this.template.querySelector('c-child002').fi();
    }
}