import { LightningElement } from 'lwc';
import  { change } from './changeContact';
import idNumber from '@salesforce/label/c.myId';
import nameNumber from '@salesforce/label/c.myName';
import phoneNumber from '@salesforce/label/c.myPhone';
import emailNumber from '@salesforce/label/c.myEmail';
const columns = [
    {label :idNumber,fieldName: 'id'},
    {label :nameNumber,fieldName: 'name'},
    {label : phoneNumber,fieldName: 'phone'},
    {label :emailNumber,fieldName: 'email',type: 'email'},
    // { label: 'Id', fieldName: 'id', type: 'id' },
    // { label: 'Name', fieldName: 'name' },
    // { label: 'Phone', fieldName: 'phone', type: 'phone' },
    // { label: 'Email', fieldName: 'email', type: 'email' },
];


export default class AddContact extends LightningElement {  
    data = [
        
            {
                
                id:1,
                name:'aaaaaa',
                phone:123456,
                email:'123456qq.com',
                
            },
        ];
        columns = columns;
        handleClick(){
            var addRecord = change();
            this.data = this.data.concat(addRecord);
            console.log(this.data)
        }
    }
    