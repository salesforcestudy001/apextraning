import { LightningElement } from 'lwc';

export default class Cmp2 extends LightningElement {
    handevent3(){
      console.log('**cmp3.event');
    }
    handevent2(){
        console.log('**cmp2.event');
    }
}