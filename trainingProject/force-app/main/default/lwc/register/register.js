import { api, LightningElement ,wire,track} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import SALESFORCE_LOGO from '@salesforce/resourceUrl/salesforce';
import USERSLOGIN_OBJECT from '@salesforce/schema/userslogin__c';
import FirstName_FIELD from '@salesforce/schema/userslogin__c.FirstName__c';
import LastName_FIELD from '@salesforce/schema/userslogin__c.LastName__c';
import Email_FIELD from '@salesforce/schema/userslogin__c.Email__c';
import Role_FIELD from '@salesforce/schema/userslogin__c.Role__c';
import Company_FIELD from '@salesforce/schema/userslogin__c.Company__c';
import Country_FIELD from '@salesforce/schema/userslogin__c.Country__c';
import Postal_Code_FIELD from '@salesforce/schema/userslogin__c.Postal_Code__c';
import Username_FIELD from '@salesforce/schema/userslogin__c.Username__c';
import getUsername from '@salesforce/apex/username.getUsername';
import getId from '@salesforce/apex/username.getId';

export default class Register extends LightningElement {

    @api recordId;
    photo = SALESFORCE_LOGO;
    userslogin__cApiName = USERSLOGIN_OBJECT;
    FirstName = FirstName_FIELD;
    LastName = LastName_FIELD;
    Email = Email_FIELD;
    Role = Role_FIELD;
    Company = Company_FIELD;
    Country = Country_FIELD;
    Postal_Code = Postal_Code_FIELD;
    Username = Username_FIELD;
    @wire(getUsername) UsernameList;
    flag = true;
    @track id;


    // fields = [FirstName_FIELD, LastName_FIELD, Email_FIELD, Role_FIELD, Company_FIELD, Country_FIELD, Postal_Code_FIELD, Username_FIELD];
    clean(e){
        let te = this.template.querySelectorAll("lightning-input-field");
        te[0].value = '';
        te[1].value = '';
        te[2].value = '';
        te[3].value = '';
        te[4].value = '';
        te[5].value = '';
        te[6].value = '';
        te[7].value = '';
        
    }

    HandanEmpty(){
        let users = this.UsernameList.data;
        for(let i = 0;i < users.length; i ++){
            // console.log(users[i].Username__c);
            let te = this.template.querySelectorAll("lightning-input-field");
            let name = te[7].value;
            // console.log('name=' + name)
            if (name == users[i].Username__c) {
                alert("用户名已存在");
                this.flag = false;
            }
        }
    }

    handleView(event) {
		// Get bear record id from bearview event
		const loginId = event.detail;
        // console.log(loginId);
		// Navigate to bear record page
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: loginId,
				objectApiName: 'userslogin__c',
				actionName: 'view',
			},
		});
	}

    getUId(){
        let te = this.template.querySelectorAll("lightning-input-field");
        let inputName = te[7].value;
        console.log(inputName);
        getId({ name: inputName })
        .then((result) => {

        // console.log(result);
        // this.id = result;
        console.log(result[0].Id);
        window.open('https://d5g00000a1ll6eaj-dev-ed.lightning.force.com/lightning/r/userslogin__c/'+result[0].Id+'/view')
    
        })
        
        // getUsername({})
        // .then((result) => {
        //     console.log(result)
        // })
    }
    

    save(){
        // this.getUId();
        // console.log(this.id)
        // refreshApex(this.id);
        

        this.flag = true;
        this.HandanEmpty()
        if(this.flag == true){
            alert("Success");    
            this.getUId();
            // console.log("Id: " + this.id[0].Id);
            // let users = this.UsernameList.data;
            // let id = users[0].Id;
            // console.log(uid);
            
           
        }

        
    }



   


}
