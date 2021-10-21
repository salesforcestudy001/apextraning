import { LightningElement ,wire} from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
export default class wireMethodtoWorkshop extends LightningElement {
    contacts;
    connectedCallback(){
        console.log('connectedCallback is success !');
    }
    renderedCallback(){
        console.log('renderedCallback is success !');
    }
    @wire(getContactList,{gettext:'$getName'})
    f1({error,data}){
        console.log('wireone');
        if(data){
            console.log('wiretwo');
            this.contacts=data;
        }
    }
    handleClick() {
        this.getName = this.template.querySelector(
            'lightning-input'
        ).value;
        alert(this.getName);
    }
}