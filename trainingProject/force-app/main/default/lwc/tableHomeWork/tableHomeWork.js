import { LightningElement } from 'lwc';
// import fetchDataHelper from './fetchDataHelper';
const columns = [
    { label: 'ID', fieldName: 'id' },
    { label: 'Name', fieldName: 'name' },
    { label: 'Title', fieldName: 'title'}
];


class constact{
    constructor (id,name,title){
        this.id = id;
        this.name = name;
        this.title = title;
    }
}

const constact01 = new constact("1","上坂茅羽耶","夏空カナタ");
const constact02 = new constact("2","綾地寧々","サノバウーチ");
const constact03 = new constact("3","三司綾瀬","Riddle Joker");

export default class TableHomeWork extends LightningElement {
    constacts = [constact01,constact02,constact03];
    columns = columns;

    // eslint-disable-next-line @lwc/lwc/no-async-await
    // async connectedCallback() {
    //     const data = await fetchDataHelper({ amountOfRecords: 100 });
    //     this.data = data;
    // }
    handleClick(){
        console.log("clicked01");
        let contact_temp = new constact("4","四季夏目","喫茶ステラと死神の蝶");
        console.log("clicked02");
        this.constacts.push(contact_temp);
        console.log(this.constacts.length);
        let ld = this.template.querySelector("lightning-datatable");
        ld.data = this.constacts;
    }

}

