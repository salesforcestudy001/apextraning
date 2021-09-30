import { LightningElement } from 'lwc';

export default class Parent001 extends LightningElement {
    //handleClick(){
       // this.template.querySelect('c-child001').f1();
    //}
    
    handleClick(){
         console.log("点击进来");
         this.template.querySelector('c-child001').returnvalue();
       
    }
}
