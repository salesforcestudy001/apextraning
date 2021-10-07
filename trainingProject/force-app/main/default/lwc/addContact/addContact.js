import { LightningElement } from 'lwc';
import  { change } from './changeContact';
const columns = [
    { label: 'Id', fieldName: 'id', type: 'id' },
    { label: 'Name', fieldName: 'name' },
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Email', fieldName: 'email', type: 'email' },
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
    