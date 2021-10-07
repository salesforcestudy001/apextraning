import { LightningElement, track } from 'lwc';
import { con } from 'c/con';

const columns = [
    { label: 'ID', fieldName: 'Id' },
    { label: 'NAME', fieldName: 'Name' },
    { label: 'TITLE', fieldName: 'Title'}
];
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
