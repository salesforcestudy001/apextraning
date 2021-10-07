/*
 * @Author: your name
 * @Date: 2021-10-07 12:06:32
 * @LastEditTime: 2021-10-07 13:01:41
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \trainingProject\force-app\main\default\lwc\addContact\addContact.js
 */
import { LightningElement, track } from 'lwc';
import {contact} from 'c/jsLibrary';

const columns = [
    { label: 'ID', fieldName: 'Id' },
    { label: 'NAME', fieldName: 'Name' },
    { label: 'TITLE', fieldName: 'Title'}
];
const contact001=new contact(1,"Amy Taylor","VP of Engineering");
const contact002=new contact(2,"Michael Jones","VP of Sales");
const contact003=new contact(3,"Jennifer Wu","CEO");
export default class AddContact extends LightningElement {
    @track contacts=[contact001,contact002,contact003];
    columns=columns;
    conLength=this.contacts.length;
    addHandler(){
        // console.log("jinlaile++");
        let qs=this.template.querySelector("lightning-datatable");
        // this.per.sayName();
        let duck=new contact(this.contacts.length+1,this.contacts[Math.round(Math.random()*2)].Name,this.contacts[Math.round(Math.random()*2)].Title);
        this.contacts.push(duck);
        qs.data=this.contacts;
        this.conLength=this.contacts.length;
        // console.log(this.contacts[this.contacts.length-1].Id);
        // console.log(this.contacts[this.contacts.length-1].Name);

    }
    minusHandler(){
        // console.log("jinlaile--");
        let qs=this.template.querySelector("lightning-datatable");
        if (this.contacts.length>3) {
            this.contacts.pop();
            qs.data=this.contacts;
            this.conLength=this.contacts.length;
            // console.log(this.contacts[this.contacts.length-1].Id);
            // console.log(this.contacts[this.contacts.length-1].Name);
        }else{
            alert('cant do this');
        }      
    }
}