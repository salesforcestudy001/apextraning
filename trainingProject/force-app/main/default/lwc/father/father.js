import { LightningElement } from 'lwc';

export default class CheckboxGroupBasic extends LightningElement {
    loginn(){
        this.template.querySelector('c-child').loginn();
    }  
}