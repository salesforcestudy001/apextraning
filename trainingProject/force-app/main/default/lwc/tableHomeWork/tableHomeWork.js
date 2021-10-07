import ContactMobile from '@salesforce/schema/Case.ContactMobile';
import { LightningElement,track } from 'lwc';
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

    @track
    show = false
    showModal() {
        this.show = !this.show;
    }

    constacts = [constact01,constact02,constact03];
    columns = columns;

    // eslint-disable-next-line @lwc/lwc/no-async-await
    // async connectedCallback() {
    //     const data = await fetchDataHelper({ amountOfRecords: 100 });
    //     this.data = data;
    // }
    AddLine(){

        let uid = this.constacts.length + 1;
        let uname;
        let title;
        let inputList = this.template.querySelectorAll("lightning-input");
        for(let i = 0;i < inputList.length ; i ++){
            if(inputList[i].name == "title"){
                title = inputList[i].value;
            }else if(inputList[i].name == "name"){
                uname = inputList[i].value;
            }
        }



        // console.log("clicked01");
        let contact_temp = new constact(uid,uname,title);
        // console.log("clicked02");
        this.constacts.push(contact_temp);
        // console.log(this.constacts.length);
        let ld = this.template.querySelector("lightning-datatable");
        ld.data = this.constacts;

        this.show = !this.show;
    }

    DeleteLine(){
        let index;
        let inputList = this.template.querySelectorAll("lightning-input");

        for(let j = 0;j < inputList.length ; j ++){
            if(inputList[j].name == "delete" ){
                index = inputList[j].value;
            }
        }
        console.log("index:  " + index);
        
        let flag = 0;

        for(let i = 0;i < this.constacts.length; i ++){
            if(this.constacts[i] != null){
                let id_temp = this.constacts[i].id;
                // console.log("id:  " + id_temp);
                if(id_temp == index){
                    console.log("deleteid:  " + id_temp);
                    console.log("I: " + i);
                    console.log(this.constacts[i]);
                    delete this.constacts[i];
                    flag = 1;
                    break;
                }
            }
        }
        if(flag == 0){
            alert("無効のID！！");
        }

        console.log(this.constacts);
        let ld = this.template.querySelector("lightning-datatable");
        ld.data = this.constacts;
        this.show = !this.show;
    }

}

