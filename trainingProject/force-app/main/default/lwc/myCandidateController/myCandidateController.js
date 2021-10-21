import { LightningElement ,wire , api} from 'lwc';
import getCandidateList from '@salesforce/apex/CandidateController.getCandidateList';
import deleteCandidate from '@salesforce/apex/CandidateController.deleteCandidate';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex} from '@salesforce/apex';
const columns = [
    { label: 'CandidateNo', fieldName: 'Name', type: 'Name' },
    { label: '名字', fieldName: 'Name__c' },
    { label: '年龄', fieldName: 'age__c' },
    { label: '电话', fieldName: 'Phone__c' },
    {label: 'Email', fieldName: 'Email__c', type: 'email'},
    { label: 'Education', fieldName: 'Education__c' },

];
const DELAY = 300;
export default class MyCandidateController extends LightningElement {
    searchKey = '';
    @api recordId;

    @wire(getCandidateList, { searchKey: '$searchKey' ,page:'$page'})
    Candidate__c;
    columns = columns;
    handleKeyChange(event) {
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        this.delayTimeout = setTimeout(() => {
            this.searchKey = searchKey;
        }, DELAY);
    }
    show=false;
    selectdetail(){
       let all= this.template.querySelector('lightning-datatable');
       this.recordId=all.selectedRows[0];
    }

    nameId;
    deleteCandidate(event){
        // window.clearTimeout(this.delayTimeout);
        let inputField= this.template.querySelector('lightning-datatable');
        this.nameId=[];
        this.nameId=inputField.selectedRows;
        // }
        deleteCandidate({NameId:this.nameId})
        .then(result=>{
            alert('删除成功');
            refreshApex(this.Candidate__c);
        })
        .catch(error=>{
            console.log(error.body.message);
        });
        refreshApex(this.Candidate__c);
    }
     edit(){
         this.show = true;
     }

     handleSuccess(event) {
        refreshApex(this.Candidate__c);
        const toastEvent = new ShowToastEvent({
            title: "数据添加成功",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
        window.open.reload;
    }
    handleReset(event){
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
        this.show = false;
     }
     beforepage=false;
     afterpage=true;
     page=0;
     page1(){
         this.beforepage=true;
         this.afterpage=true;
         this.page=this.page-1;
         if(this.page==0){
             this.beforepage=false;
             this.afterpage=true;
         }
     }
     page2(){
        this.beforepage=true;
        console.log(this.Candidate__c.data.length);
        if(this.Candidate__c.data.length!=10){
            alert("已到达最后一页");
           this.afterpage=false;
        }
        else{
            this.page=this.page+1;
        }
       
     }
     
}