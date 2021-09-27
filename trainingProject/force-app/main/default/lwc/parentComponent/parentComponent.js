// import UserPreferencesShowEmailToExternalUsers from "@salesforce/schema/User.UserPreferencesShowEmailToExternalUsers";
import { api } from "lwc";
import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    cons = [
        {name:'a',phone:'110',email:'110@qq.com'},
        {name:'b',phone:'120',email:'120@qq.com'},
        {name:'c',phone:'130',email:'130@qq.com'},
    ]

    
}