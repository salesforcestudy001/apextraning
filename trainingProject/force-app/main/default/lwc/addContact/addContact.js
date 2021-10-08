import { LightningElement } from 'lwc';
import { cont } from 'c/cont';
import lbID from '@salesforce/label/c.myID';
import lbNAME1 from '@salesforce/label/c.myName1';
import lbTITLE from '@salesforce/label/c.myTITLE';

/*const columns = [
    { label: 'ID', fieldName: 'Id' },
    { label: 'NAME', fieldName: 'Name' },
    { label: 'TITLE', fieldName: 'Title'}
];*/
const columns = [
    { label: lbID, fieldName: 'Id' },
    { label: lbNAME1, fieldName: 'Name' },
    { label: lbTITLE, fieldName: 'Title'}];
export default class AddContact extends LightningElement {
    contacts=[
        {
            Id:1,
            Name:'cui',
            Title:'C++',
        },
        {
            Id:2,
            Name:'Daming',
            Title:'java',
        },
        {
            Id:3,
            Name:'lingling',
            Title:'salesforce',
        },
    ];
    columns=columns;
    addHandler(){
        console.log("添加一条记录！");
        let qs=this.template.querySelector("lightning-datatable");
        var addRecord = cont();
        addRecord.Id=this.contacts.length+1;
        this.contacts.push(addRecord);
        qs.data=this.contacts;
        

    }
    minHandler(){
        console.log("删除一条记录");
        let qs=this.template.querySelector("lightning-datatable");
        if (this.contacts.length>3) {
            this.contacts.pop();
            qs.data=this.contacts;
        }else{
            alert('false');
        }      
    }
}