import { LightningElement } from 'lwc';

export default class Cmp3 extends LightningElement {
    clickHandler(){
        //定义一个事件
        //let e=new CustomEvent('previous',{detail:111});
        let e=new CustomEvent('previous',{detail:111,bubbles:true,composed:true});
        //抛出事件
        this.dispatchEvent(e);
    }
}