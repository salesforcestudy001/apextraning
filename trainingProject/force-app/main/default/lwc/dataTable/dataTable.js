import { LightningElement } from 'lwc';

const columns = [
    { label: 'Name', fieldName: 'name', type: 'text'},
    { label: 'Email', fieldName: 'email', type: 'email'},
    { label: 'Phone', fieldName: 'phone', type: 'phone'},
    { label: 'Country', fieldName: 'country', type: 'text'}
    // { label: 'Time', fieldName: 'time', type: 'date' }
];

class contact{
    constructor(name,email,phone,country){
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.country = country;
        // this.time = time;
    }
}
const contact01 = new contact("Amy","Amy@cloudhub.com","2352235235","LA");
const contact02 = new contact("Betty","Betty@cloudhub.com","2352235236","NY");

export default class DataTable extends LightningElement {
    contacts = [contact01,contact02];
    columns = columns;
    name_temp = "name" + Math.random();
    email_temp = "email" + Math.random();
    phone_temp = "phone" + Math.random();
    country_temp = "country" + Math.random();
    // time_temp = "time" + Math.random();

    getSelectedName(event) {
        const selectedRows = event.detail.selectedRows;
        // Display that fieldName of the selected rows
        for (let i = 0; i < selectedRows.length; i++){
            alert("You selected: " + selectedRows[i].name);
        }
    }

    AddaLine(){
        // console.log("clicked");
        let contact_temp = new contact(this.name_temp,this.email_temp,this.phone_temp,this.country_temp,this.time_temp);
        console.log("name:  " + this.name_temp + "email:  " + this.email_temp + "phone:  " + this.phone_temp
        + "country:  " + this.country_temp );
        this.contacts.push(contact_temp);
        console.log("ListLength:  " + this.contacts.length);

        // get this label
        let table_cus = this.template.querySelector("lightning-datatable");
        table_cus.data = this.contacts;
    }


        
}
