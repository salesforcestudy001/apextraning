import { LightningElement } from 'lwc';

export default class ParentLogin extends LightningElement {

    // NameUser;
    // NamePassword;

    loginParent(){
        // console.log(this.NameUser + "  " + this.PasswordUser);
        this.template.querySelector('c-child-login').login();
    }

    // getName(event){
    //     // this.NameUser = event.target.value;
    //     // console.log("Name" + event.target.value);

    //     this.template.querySelector('c-child-login').nameget(event.target.value);
    // }
    // getPassword(event){
    //     // this.PasswordUser = event.target.value;
    //     // console.log("Password" + event.target.value);

    //     this.template.querySelector('c-child-login').passwordget(event.target.value);
    // }
    
}