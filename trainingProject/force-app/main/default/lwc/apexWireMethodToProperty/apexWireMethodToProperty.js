import { LightningElement ,wire} from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';



export default class ApexWireMethodToProperty extends LightningElement {
    // @wire(getContactList) contacts;
    contacts;
    connectedCallback(){
        console.log('***connectedCallback***');
    }
    renderedCallback(){
        console.log('***renderedCallback***');
    }
    @wire(getContactList,{searchtext:'$searchName'})
    f1({error,data}){
        console.log('wire1');
        if(data){
            console.log('wire2');
            this.contacts=data;
        }

    }
    handleClick() {
        this.searchName = this.template.querySelector(
            'lightning-input'
        ).value;
        alert(this.searchName);
    }
}