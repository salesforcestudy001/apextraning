import { LightningElement } from 'lwc';
import { f1,f2 } from './myFunction';
import { function21,function22 } from 'c/mortgage';

export default class TodoItem extends LightningElement {
    handleClick(){
        f1();
        f2();
        function21();
        function22(1,2);
    }
}