import { LightningElement } from 'lwc';
import { functionB1,functionB2 }from 'c/mortgage';

export default class TodoApp extends LightningElement {
    handleClick(){
        functionB1();
        functionB2(1,2);
    }
}