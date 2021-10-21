import { LightningElement, wire } from 'lwc';
import getCandidates from '@salesforce/apex/candidateHomework.getCandidates'
import deleteCandidates from '@salesforce/apex/candidateHomework.deleteCandidates'
import { refreshApex } from '@salesforce/apex';

const columns=[{label: '名前', fieldName: 'Candidate_Name__c'},
               {label: '年齢', fieldName: 'Candidate_Age__c'},
               {label: '電話', fieldName: 'Candidate_Phone__c'},
               {label: '電子メール', fieldName: 'Candidate_Email__c'},
               {label: '教育', fieldName: 'Candidate_Education__c'},
               {label: 'SSN', fieldName: 'Candidate_SSN__c'},
               {label: '必要なビザ', fieldName: 'Candidate_Visa_Required__c'}];

export default class CT extends LightningElement {
    show = true;
    
    objectApiName = 'Candidate_Test__c';
    columns = columns;
    recordId = null;
    showdata;
    

    data;
    canName = null;

    pages = 1;
    currentPage = 1;
    lastPageCounts = 0;
    Contents;

    @wire (getCandidates,{name:'$canName'})

    // get contents
    getrecord(result){
        if (result.data) {
            this.Contents = result;
            this.data = this.Contents.data;
            this.recordId = this.data[0].Id;
            this.pages = Math.ceil(this.data.length / 10);
            this.currentPage = 1;
            this.lastPageCounts = this.data.length % 10;
            console.log('this.pages');
            console.log(this.pages);
                if (this.lastPageCounts == 0) {
                    console.log(this.lastPageCounts);
                    this.showdata=[this.data[ this.currentPage * 10-10],
                                   this.data[ this.currentPage * 10-9],
                                   this.data[ this.currentPage * 10-8],
                                   this.data[ this.currentPage * 10-7],
                                   this.data[ this.currentPage * 10-6],
                                   this.data[ this.currentPage * 10-5],
                                   this.data[ this.currentPage * 10-4],
                                   this.data[ this.currentPage * 10-3],
                                   this.data[ this.currentPage * 10-2],
                                   this.data[ this.currentPage * 10-1]];
                }else{
                    if (this.pages == 1) {
                        console.log(this.lastPageCounts);
                        this.showdata=[ ];
                        for (let i = 0; i < this.lastPageCounts; i++) {
                            this.showdata=this.showdata.concat(this.data[i]);
                        }
                    }else{
                        this.showdata=[this.data[ this.currentPage * 10-10],
                                       this.data[ this.currentPage * 10-9],
                                       this.data[ this.currentPage * 10-8],
                                       this.data[ this.currentPage * 10-7],
                                       this.data[ this.currentPage * 10-6],
                                       this.data[ this.currentPage * 10-5],
                                       this.data[ this.currentPage * 10-4],
                                       this.data[ this.currentPage * 10-3],
                                       this.data[ this.currentPage * 10-2],
                                       this.data[ this.currentPage * 10-1]];
                    }
                }
        }else{
              this.data = null;
              this.pages = 1;
              this.currentPage = 1;
              this.showdata = this.data;
        }
    }

    // edit action
    edithandle(){
        if (this.recordId == null) {
            alert('Edit Failed!');
        }else{
            this.show = false;
        }
    }

    // cancel action
    cancelhandle() {
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
        this.show = true;
        const inputField = this.template.querySelector(
            'lightning-datatable'
        );
        inputField.hideCheckboxColumn=false;
    }

    // save action 
    savehandle(){
        this.show = true;
        const inputField = this.template.querySelector(
            'lightning-datatable'
        );
        inputField.hideCheckboxColumn = false;
    }

    handlechange(event){
         this.canName = event.target.value;
     }

    getSelectedName(event){
         if (event.detail.selectedRows.length == 0) {
            this.recordId = this.data[0].Id;
         }else{
            this.recordId = event.detail.selectedRows[0].Id; 
         }   
    }

    //  向前翻页action
    previousHandler(){
         if (this.data) {
             if (this.currentPage == 1) {
                 alert('It is the first page, You can not turn forward!');
             }else {
                this.currentPage--;
                this.showdata=[this.data[ this.currentPage * 10-10],
                               this.data[ this.currentPage * 10-9],
                               this.data[ this.currentPage *  10-8],
                               this.data[ this.currentPage * 10-7],
                               this.data[ this.currentPage * 10-6],
                               this.data[ this.currentPage * 10-5],
                               this.data[ this.currentPage * 10-4],
                               this.data[ this.currentPage * 10-3],
                               this.data[ this.currentPage * 10-2],
                               this.data[ this.currentPage * 10-1]];
             }
         }
     }

    //  向后翻页 action
    nextHandler(){
        if (this.data) {
            if (this.currentPage == this.pages) {
                alert('It is the last page. You can not turn back and forth!');
            }else {
               this.currentPage++;
               this.showdata = [ ];
               if(this.currentPage == this.pages){
                   for (let i = 0; i < this.lastPageCounts; i++) {
                       console.log(i);
                       let no = (this.currentPage - 1 ) * 10 + i;
                    this.showdata = this.showdata.concat(this.data[no]);
                   }
                   console.log(this.showdata.length);
               }else{
                    this.showdata = [this.data[ this.currentPage * 10-10],
                                     this.data[ this.currentPage * 10-9],
                                     this.data[ this.currentPage * 10-8],
                                     this.data[ this.currentPage * 10-7],
                                     this.data[ this.currentPage * 10-6],
                                     this.data[ this.currentPage * 10-5],
                                     this.data[ this.currentPage * 10-4],
                                     this.data[ this.currentPage * 10-3],
                                     this.data[ this.currentPage * 10-2],
                                     this.data[ this.currentPage * 10-1]];
               }
            }
        }
     }

    //  + action
     addHandler(){
         this.show = false;
         this.recordId = null;
         const inputField = this.template.querySelector(
            'lightning-datatable'
        );
        inputField.selectedRows = null;
        inputField.hideCheckboxColumn = true;
     }
     
    //  - action
    deleteHandler(){
        const inputField = this.template.querySelector(
            'lightning-datatable'
        );
        let ids=[];
        for (let i = 0; i < inputField.selectedRows.length; i++) {
            console.log(inputField.selectedRows[i]);
            ids=ids.concat(inputField.selectedRows[i]);
        }
        deleteCandidates({ids:ids})
        .then((result) => {
            refreshApex(this.Contents); 
        })
        .catch((error) => {
        }); 
     }

    successhandle(){
        refreshApex(this.Contents);
     }
}