import { LightningElement } from 'lwc';
import id from '@salesforce/label/c.id';
import name from '@salesforce/label/c.name';
import tital from '@salesforce/label/c.tital';
const columns = [
    { label: id, fieldName: 'Id' },
    { label: name, fieldName: 'Name'},
    { label: tital, fieldName: 'Title'},
];
const contact1 = [
    {
        Id: '',
        Name: '',
        Title: '',
    },
];

export default class HomeWorkDataTable extends LightningElement {
    columns = columns;
    contacts = [
        {
            Id: 1,
            Name: 'Amy Taylor',
            Title: 'VP of Engineering',
        },
        {
            Id: 2,
            Name: 'Michael Jones',
            Title: 'VP of Sales',
        },
        {
            Id: 3,
            Name: 'Jennifer Wu',
            Title: 'CEO',
        },
    ];
    onclickAdd(){
        this.contacts = this.contacts.concat(contact1);
    }
    onclickDelete(){
        alert('まだです');
    }
}