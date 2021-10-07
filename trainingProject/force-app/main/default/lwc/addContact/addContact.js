import { LightningElement } from 'lwc';
import { rand } from './utils';
const columns = [
    { label: 'Label', fieldName: 'name' },
    { label: 'Phone', fieldName: 'phone', type: 'phone' }
];
export default class Beaut extends LightningElement {
    data = [{name:'aaa',phone:'135'},{name:'bbb',phone:'136'}];
    columns = columns;
    handleAdd(){
        var addRecord = rand();
        this.data = this.data.concat(addRecord)
        console.log(this.data)
    }
}