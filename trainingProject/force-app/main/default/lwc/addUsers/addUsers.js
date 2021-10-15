import { LightningElement, wire} from 'lwc';
import userNameCheck from '@salesforce/apex/userNameCheck.userNameCheck';
import userName from '@salesforce/apex/userNameCheck.userName';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import PTXX_OBJECT from '@salesforce/schema/ptxx__c';
import FirstName from '@salesforce/schema/ptxx__c.FirstName__c';
import LastName from '@salesforce/schema/ptxx__c.LastName__c';
import Email from '@salesforce/schema/ptxx__c.Email__c';
import Role from '@salesforce/schema/ptxx__c.Role__c';
import Company from '@salesforce/schema/ptxx__c.Company__c';
import Country from '@salesforce/schema/ptxx__c.Country__c';
import PostalCode from '@salesforce/schema/ptxx__c.Postal_Code__c';
import Username from '@salesforce/schema/ptxx__c.Username__c';
export default class LdsCreateRecord extends LightningElement {

    @wire(userNameCheck,{fld:'Role__c'}) 
    wiredContacts({ error, data }) {
        if (data) {
            for(let i = 0; i<data.length; i++){
                let json = {label: data[i], value: data[i]};
                this.options.push(json);
            }
            console.log(this.options)
        } else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
    } 
    @wire(userNameCheck,{fld:'Country__c'}) 
    wiredContact({ error, data }) {
        if (data) {
            for(let i = 0; i<data.length; i++){
                let json = {label: data[i], value: data[i]};
                this.cOptions.push(json);
            }
            console.log(this.cOptions)
        } else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
    } 
    firstname = '';
    lastname = '';
    email = '';
    options=[];
    role = '';
    cOptions=[];
    country = '';
    company = '';
    pcode = '';
    usernames = '';
    
    o(){
        let ld = this.template.querySelectorAll("lightning-combobox");
        ld[0].options = this.options;
    }

    oo(){
        let ld = this.template.querySelectorAll("lightning-combobox");
        ld[1].options = this.cOptions;
    }

    handleFirst(e){
        this.firstname = e.target.value;   
    }
    handleLast(e){
        this.lastname = e.target.value;
    }
    handleEmail(e){
        this.email = e.target.value
    }
    handleChange(e){
        this.role = e.target.value
    }
    handleChangeCountry(e){
        this.country = e.target.value
    }
    handleCompany(e){
        this.company = e.target.value
    }
    handlePCode(e){
        this.pcode = e.target.value
    }
    userNameChange(e){
        this.usernames = e.currentTarget.value  
    }
    createAccount() {
        userName({ searchTerm: this.usernames })
        .then((result) => {
            console.log(result)
            if(result.length == 1){
                alert('用户名已经存在')
            }
        })
        .catch((error) => {
        });

        const fields = {};
        fields[FirstName.fieldApiName] = this.firstname;
        fields[LastName.fieldApiName] = this.lastname;
        fields[Email.fieldApiName] = this.email;
        fields[Role.fieldApiName] = this.role;
        fields[Country.fieldApiName] = this.country;
        fields[Company.fieldApiName] = this.company;
        fields[PostalCode.fieldApiName] = this.pcode;
        fields[Username.fieldApiName] = this.usernames;
        console.log("fields");
        console.log(fields)
        const recordInput = { apiName: PTXX_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(res => {
                // this.accountId = account.id;
                console.log(res)
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Account created',
                        variant: 'success',
                    }),
                );
                window.open('https://d5g00000auksiear-dev-ed.lightning.force.com/lightning/r/ptxx__c/'+res.id+'/view','_blank');
            })
            .catch(error => {
                console.log(Object.keys(error.body.output.fieldErrors)[0])
                this.dispatchEvent(                   
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: Object.keys(error.body.output.fieldErrors)[0].replace('__c','')+'格式错误',
                        variant: 'error',
                    }),
                );
            });
    }

    accountObject = PTXX_OBJECT;
    myFields = [ Email, Role, Company, Country, PostalCode, Username];

}