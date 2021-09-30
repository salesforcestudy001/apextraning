import TickerSymbol from '@salesforce/schema/Account.TickerSymbol';
import { LightningElement ,api} from 'lwc';

export default class ChildLogin extends LightningElement {

    NameChild;
    PasswordChild;

    @api 
    login(){
        
        console.log("Login!!");
        let name = this.querySelectorAll('lightning-input');
        for(let i = 0;i < name.length;i ++){
            if(name[i].label == "Name"){
                this.NameChild = name[i].value;
                console.log(this.NameChild);
            }
            if(name[i].label == "Password"){
                this.PasswordChild = name[i].value;
                console.log(this.PasswordChild);
            }
        }
        console.log(this.NameChild + "   "  + this.PasswordChild);
        alert("Name: " + this.NameChild + "   " + "Password:" + this.PasswordChild);
        
    }

    //  @api
    //  nameget(event){
    //     // console.log(event);
    //     this.NameChild = event;
    //  }
    //  @api
    //  passwordget(event){
    //     // console.log(event);
    //     this.PasswordChild = event;
    // }
    
}