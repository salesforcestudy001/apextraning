import { LightningElement } from 'lwc';
export default class Excercise extends LightningElement {
    number1=0;
    number2=0;
    result=0;
    isRight=false;
    handleChange(event){
        const field = event.target.name;
        if(field ==='number1'){
            this.number1 = event.target.value;
        }else if (field ==='number2'){
            this.number2 = event.target.value;
        }else if (field ==='result'){
            this.result = event.target.value;
    }
    let tempResult=parseInt(this.number1)+parseInt(this.number2);
    console.log(tempResult);
    console.log(parseInt(this.result));
    if(tempResult == parseInt(this.result)){
        this.isRight=true;
    }else{
        this.isRight=false;
    }
    console.log('**this.isRight='+this.isRight);
    console.log('*****');
}
}