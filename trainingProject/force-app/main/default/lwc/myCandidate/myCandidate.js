import { LightningElement ,wire,api} from 'lwc';
import CandidateList from '@salesforce/apex/CandidateValue.CandidateList';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {refreshApex } from '@salesforce/apex';
import minHandler from '@salesforce/apex/CandidateValue.minHandler';

const columns = [
    { label: 'CandidateNo', fieldName: 'Name' },
    { label: '名前', fieldName: 'First_Name__c' },
    { label: '年龄', fieldName: 'Age__c' },
    { label: '电话', fieldName: 'Phone__c'},
    { label: 'Email', fieldName: 'Email__c'},
    { label: 'Education', fieldName: 'Education__c' },
];

const DELAY = 300;
export default class MyCandidate extends LightningElement {
    Firstname='';  
    objectApiName='Candidate__c';
    @api recordId;

    @wire(CandidateList,{Firstname:'$Firstname',page:'$page'})
    Candidate__c;
    columns = columns;
  

//点击搜索框
  
handlechange(event){
    window.clearTimeout(this.delayTimeout);
    const Firstname = event.target.value;
    this.delayTimeout = setTimeout(() => {
        this.Firstname = Firstname;
    }, DELAY);
}


//点击取消按钮
    handleReset(){
            const inputFields = this.template.querySelectorAll( 'lightning-input-field');
            if (inputFields) {
                inputFields.forEach(field => {
                    field.reset();
                });
            }
            this.show=false;
         }

//
    show=false;
    Selectdetail(){
        let all=this.template.querySelector('lightning-datatable');
        this.recordId=all.selectedRows[0];
    }

//点击+
    addHandler(){
        this.show=true; 
        this.recordId=null; 
    }
   
//点击-
    records;
    minHandler(event){
        console.log("删除一条记录");
        let inputField=this.template.querySelector('lightning-datatable');
        this.records=[];
        this.records=inputField.selectedRows;
        minHandler({FirstNameId:this.records})
        .then(result=>{
                alert('删除成功！！!');
                refreshApex(this.Candidate__c);
            })
            .catch(error=>{
                console.log(error.body.message);
            });
            refreshApex(this.Candidate__c);
           
    }

    page1 =false;
    page2 = true;
    page=0;
//前页
    upHandler(){
        this.page2=true;
        this.page = this.page - 1;
        if (this.page ==0) {
            this.page1= false;
        }
    }

//后页
   downHandler(){
    this.page1=true;
    let count=(Number)(Math.floor(this.Candidate__c.data.length/10));
    this.page=this.page+1;
    if(count==this.page){
        this.page2=false;  
   }
}

//添加数据
    addSuccess(event){
        refreshApex(this.Candidate__c);
        const toastEvent=new ShowToastEvent({
            title:"数据添加成功",
            message:"Record ID: " + event.detail.id,
            variant:"success"
        });
        this.dispatchEvent(toastEvent);
      
    }

//点击编辑
    handEdit(){
       this.show=true;
    }

}