import { LightningElement } from 'lwc';

export default class AddNumber extends LightningElement {
    number01 = 0;
    number02 = 0;
    result01 = 0;
    isRight=false;
    handleChange(event) {
        const field = event.target.name;
        if (field === 'number01') {
            this.number01 = event.target.value;
        } else if (field === 'number02') {
            this.number02 = event.target.value;
        }else if (field === 'result01') {
            this.result01 = event.target.value;
        }
        let tempResult=parseInt(this.number01)+parseInt(this.number02);
        console.log(tempResult);
        console.log(parseInt(this.result01));
        if(tempResult==parseInt(this.result01)){
            this.isRight=true;
        }else{
            this.isRight=false;
        }
        console.log('*******this.isRight='+this.isRight);
        console.log('***********');
    }

}