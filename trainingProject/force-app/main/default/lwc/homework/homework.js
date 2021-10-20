import { LightningElement, api, wire,track } from 'lwc';
import getCandidateListAll from '@salesforce/apex/candidateList.getCandidateListAll';
import getCandidateList from '@salesforce/apex/candidateList.getCandidateList';
import CANDIDATE_OBJECT from '@salesforce/schema/Candidate__c';
import Name_FIELD from '@salesforce/schema/Candidate__c.Name';
import FirstName__c_FIELD from '@salesforce/schema/Candidate__c.First_Name__c';
import LastName__c_FIELD from '@salesforce/schema/Candidate__c.Last_Name__c';
import Phone__c_FIELD from '@salesforce/schema/Candidate__c.Phone__c';
import Email__c_FIELD from '@salesforce/schema/Candidate__c.Email__c';
import Education__c_FIELD from '@salesforce/schema/Candidate__c.Education__c';
import deleteById from '@salesforce/apex/candidateList.deleteById';
import getCount from '@salesforce/apex/candidateList.getCount';


const columns = [
    { label: 'Id', fieldName: "Id" },
    { label: 'Name', fieldName: "Name" },
    { label: 'FirstName', fieldName: "First_Name__c" },
    { label: 'LastName', fieldName: "Last_Name__c" },
    { label: 'Phone', fieldName: "Phone__c" },
    { label: 'Email', fieldName: "Email__c" },
    { label: 'Education', fieldName: "Education__c" },
];



export default class Homework extends LightningElement {

    show = false;
    buttonpage1 = false;
    buttonpage2 = true;

    @api recordId;
    candidate__cApiName = CANDIDATE_OBJECT;
    Name = Name_FIELD;
    FirstName = FirstName__c_FIELD;
    LastName = LastName__c_FIELD;
    Phone = Phone__c_FIELD;
    Email = Email__c_FIELD;
    Education = Education__c_FIELD;

    @track resultList;
    
    // @wire(getCandidateList, {firstName:'$firstName',lastName:'$lastName',page:'$page'}) candidates;
    @wire(getCandidateListAll,{page:'$page'} ) candidates;
    @wire(getCount) count;


    columns = columns;
    rowOffset = 0;

    pageList = [];
    // count;
    page = 0;
    IdList = [];
    // var s = new Set();
    searchName(){
        let first =  this.template.querySelectorAll('lightning-input');
        let ld = this.template.querySelectorAll("lightning-datatable");
        console.log(first[0].value);
        getCandidateList({firstName:first[0].value,lastName:first[0].value})
        .then((result) =>{
            console.log(result);
            ld[0].data = result;
        })
        
     }

    getSelectedName(event){
        if (event.detail.selectedRows.length>0) {
            let IdString =  event.detail.selectedRows[0].Id;
            this.recordId = IdString;            
        }
        console.log('111+'+event.detail.selectedRows.length)
        for (let i = 0; i < event.detail.selectedRows.length; i++) {           
            this.IdList.push(event.detail.selectedRows[i].Id)          
        }
        console.log(this.IdList)
     }

    deleteId(){
        let ld = this.template.querySelectorAll("lightning-datatable");
        deleteById({ IdList: this.IdList, page: this.page })
        .then((result) =>{
            alert('删除成功')
            console.log(result);
            ld[0].data = result;
            this.IdList = [];
        })
    }

    page1(){
        this.buttonpage2=true;
        this.page = this.page - 1;
        if (this.page ==0) {
            // alert('f')
            this.buttonpage1 = false;
        }
        
    }

    page2(){
        console.log(this.count.data)
        this.buttonpage1 = true;
        let i = (Number)(Math.floor(this.count.data/3));
            console.log(i)
            this.page = this.page + 1;
            console.log(this.page)
            if (i == this.page ) {                
                this.buttonpage2 = false;
            }
        

        

    }

    clean(){
        let te = this.template.querySelectorAll("lightning-input-field");
        te[0].value = '';
        te[1].value = '';
        te[2].value = '';
        te[3].value = '';
        te[4].value = '';
     }

    save(){
        let ld = this.template.querySelectorAll("lightning-datatable");
        if (this.recordId != null) {
            alert('修改成功')
        }else{
            alert('添加成功')
        }

        // window.location.reload();
        
        // refreshApex(getCandidateList);
        getCandidateList({page:this.page})
        .then(result =>{
            console.log(result)
            // this.resultList = result;
            // ld[0].data = this.resultList;
            ld[0].data = result;
            console.log(1111111)
            // console.log(this.resultList);
            this.show = false;
            this.IdList = [];

        })
     }

     add1(){
        this.show = true;
    }

}