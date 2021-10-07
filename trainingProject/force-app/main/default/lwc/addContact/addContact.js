import { LightningElement } from 'lwc';
import { charFunction } from './myFunction';

const columns = [
    {label:'ID',fieldName:'id'},
    {label:'NAME',fieldName:'name'},
    {label:'TITLE',fieldName:'title'}
];

/*const data = [{
    id: '001',
    name:'Tom',
    title:'Student01'
},
{
    id: '002',
    name:'Amy',
    title:'Student02'
},
{
    id: '003',
    name:'Sam',
    title:'Student03'
}];*/
export default class AddContact extends LightningElement {
    data = [];
    columns = columns;
    handleClick(){
        //console.log("clicked01");
        const data1 = charFunction();
        this.data = this.data.concat(data1);
        console.log(this.data)   
    }
}