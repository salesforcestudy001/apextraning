import { LightningElement } from 'lwc';

export default class NewCount extends LightningElement {
    firstNumber='';
    secondNumber='';
    finalNumber=this.firstNumber+this.secondNumber;
    endNumber='';
    

    handleChange(event) {
        const field = event.target.value;
        if (field === 'firstNumber') {
            this.firstNumber = event.target.value;
        } else if (field === 'secondNumber') {
            this.secondNumber = event.target.value;
        }else if (field === 'finalNumber') {
            this.finalNumber = event.target.value;
        }
        
    }
    get endNumber() {
        return this.finalNumber;
    }

}