import { LightningElement, track } from 'lwc';

export default class Paginatorsub extends LightningElement {
    @track theContact={
        id:1,
        name:'tanake',
        age:12
    };
    clickHandler()
    {
        alert('sub');
        
        let e = new CustomEvent('previous',{detail:this.theContact});
        this.dispatchEvent(e);
    }
}