/*
 * @Author: your name
 * @Date: 2021-10-19 09:09:47
 * @LastEditTime: 2021-10-19 14:31:01
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \trainingProject\force-app\main\default\lwc\candidateLogin\candidateLogin.js
 */
import { LightningElement, wire } from 'lwc';
import getCandidates from '@salesforce/apex/candidateControler.getCandidates'
import deleteCandidates from '@salesforce/apex/candidateControler.deleteCandidates'
import { refreshApex } from '@salesforce/apex';
const columns=[{label:'CandidateNo',fieldName:'CandidateNo__c'},
               {label:'名前',fieldName:'Name'},
               {label:'年齢',fieldName:'Age__c'},
               {label:'電話',fieldName:'Phone__c'},
               {label:'Email',fieldName:'Email__c'},
               {label:'Education',fieldName:'Education__c'}];
export default class CandidateLogin extends LightningElement {
    show=true;
    objectApiName='Candidate2__c';
    recordId=null;
    columns=columns;
    canName=null;
    data;
    showdata;
    pages=1;
    currentPage=1;
    lastPageCounts=0;
    Records;
    @wire (getCandidates,{name:'$canName'})
    getrecord(result){
        if (result.data) {
            this.Records=result;
            this.data=this.Records.data;
            this.recordId=this.data[0].Id;
            this.pages=Math.ceil(this.data.length/10);
            this.currentPage=1;
            this.lastPageCounts=this.data.length%10;
            console.log('this.pages');
                console.log(this.pages);
                if (this.lastPageCounts==0) {
                    console.log(this.lastPageCounts);
                    this.showdata=[this.data[ this.currentPage*10-10],
                               this.data[ this.currentPage*10-9],
                               this.data[ this.currentPage*10-8],
                               this.data[ this.currentPage*10-7],
                               this.data[ this.currentPage*10-6],
                               this.data[ this.currentPage*10-5],
                               this.data[ this.currentPage*10-4],
                               this.data[ this.currentPage*10-3],
                               this.data[ this.currentPage*10-2],
                               this.data[ this.currentPage*10-1]];
                            //    let qs=this.template.querySelector('lightning-datatable');
                            //    qs.data=this.showdata;
                }else{
                    if (this.pages==1) {
                        console.log(this.lastPageCounts);
                        this.showdata=[];
                        for (let index = 0; index < this.lastPageCounts; index++) {
                            this.showdata=this.showdata.concat(this.data[index]);
                        }
                    }else{
                        this.showdata=[this.data[ this.currentPage*10-10],
                               this.data[ this.currentPage*10-9],
                               this.data[ this.currentPage*10-8],
                               this.data[ this.currentPage*10-7],
                               this.data[ this.currentPage*10-6],
                               this.data[ this.currentPage*10-5],
                               this.data[ this.currentPage*10-4],
                               this.data[ this.currentPage*10-3],
                               this.data[ this.currentPage*10-2],
                               this.data[ this.currentPage*10-1]];
                    }
                    // let qs=this.template.querySelector('lightning-datatable');
                    // qs.data=this.showdata;
                    // console.log(this.showdata.length);
                }
        }else{
            this.data=null;
            this.pages=1;
            this.currentPage=1;
            this.showdata=this.data;
        }
    }
    handleEdit(){
        if (this.recordId==null) {
            alert('編集できない');
        }else{
            this.show=false;
        }
    }
    handleReset(event) {
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
        this.show=true;
        const inputField = this.template.querySelector(
            'lightning-datatable'
        );
        inputField.hideCheckboxColumn=false;
     }
     handleSave(){
        this.show=true;
        const inputField = this.template.querySelector(
            'lightning-datatable'
        );
        inputField.hideCheckboxColumn=false;
     }
     handlechange(event){
         this.canName=event.target.value;
     }
     getSelectedName(event){
         if (event.detail.selectedRows.length==0) {
            this.recordId=this.data[0].Id;
         }else{
            this.recordId=event.detail.selectedRows[0].Id; 
         }   
     }
     preHandler(){
         if (this.data) {
             if (this.currentPage==1) {
                 alert('已经第一页了不能向前翻页');
             }else {
                this.currentPage--;
                this.showdata=[this.data[ this.currentPage*10-10],
                               this.data[ this.currentPage*10-9],
                               this.data[ this.currentPage*10-8],
                               this.data[ this.currentPage*10-7],
                               this.data[ this.currentPage*10-6],
                               this.data[ this.currentPage*10-5],
                               this.data[ this.currentPage*10-4],
                               this.data[ this.currentPage*10-3],
                               this.data[ this.currentPage*10-2],
                               this.data[ this.currentPage*10-1]];
             }
         }
     }
     nextHandler(){
        if (this.data) {
            if (this.currentPage==this.pages) {
                alert('已经最后一页了不能向前后翻页');
            }else {
               this.currentPage++;
               this.showdata=[];
               if(this.currentPage==this.pages){
                   for (let index = 0; index < this.lastPageCounts; index++) {
                       console.log(index);
                       let no=(this.currentPage-1)*10+index;
                    this.showdata=this.showdata.concat(this.data[no]);
                   }
                   console.log(this.showdata.length);
               }else{
                this.showdata=[this.data[ this.currentPage*10-10],
                this.data[ this.currentPage*10-9],
                this.data[ this.currentPage*10-8],
                this.data[ this.currentPage*10-7],
                this.data[ this.currentPage*10-6],
                this.data[ this.currentPage*10-5],
                this.data[ this.currentPage*10-4],
                this.data[ this.currentPage*10-3],
                this.data[ this.currentPage*10-2],
                this.data[ this.currentPage*10-1]];
               }
            }
        }
     }
     plusHandler(){
         this.show=false;
         this.recordId=null;
         const inputField = this.template.querySelector(
            'lightning-datatable'
        );
        inputField.selectedRows=null;
        inputField.hideCheckboxColumn=true;
     }
     minusHandler(){
        const inputField = this.template.querySelector(
            'lightning-datatable'
        );
        let ids=[];
        for (let index = 0; index < inputField.selectedRows.length; index++) {
            console.log(inputField.selectedRows[index]);
            ids=ids.concat(inputField.selectedRows[index]);
        }
        deleteCandidates({ids:ids})
        .then((result) => {
            
        })
        .catch((error) => {
        });
        refreshApex(this.Records);
        
     }
}