import { LightningElement } from 'lwc';

export default class Paginatorparent extends LightningElement {
    renderedCallback(){
        this.template.querySelector('c-paginatorsub').addEventListener('previous',this.previousHandler);
    }
    previousHandler = (e) => {
        const theContact=e.detail;
        theContact.Name='aaaa';
        console.log('**theContact**'+JSON.stringify(theContact));
    }
    myValue='initial value';
    handleChange(evt){
        console.log('Current value of the input:'+evt.target.value);
    }
    // 1
    //previousHandler(e){
    //     alert('**previousHandler**');
    // }
    //2
    // previousHandler(e) {
    //     const theContact = e.detail;
    //     theContact.Name = 'aaaa';
    //     console.log(1);
    //     console.log(JSON.stringify(theContact))
    // }
    //3
    // renderedCallback(){
    //     this.template.querySelector('c-paginatorsub').addEventListener('previous',this.previousHandler);
    // }
    // previousHandler = (e) => {
    //     const theContact=e.detail;
    //     theContact.Name='aaaa';
    //     console.log('**theContact**'+JSON.stringify(theContact));
    // }
}