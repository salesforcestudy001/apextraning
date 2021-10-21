import { LightningElement ,wire , api} from 'lwc';
import getCandidateList from '@salesforce/apex/Cancontroller.getCandidateList';
import deleteCandidate from '@salesforce/apex/Cancontroller.deleteCand';
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
export default class MyWorkshopController extends LightningElement {
    getKey = '';
    @api recordId;

    @wire(getCandidateList, { getKey: '$getKey' ,page:'$page'})
    Candidate__c;
    columns = columns;
    handleKeyChange(event) {
        window.clearTimeout(this.delayTimeout);
        const getKey = event.target.value;
        this.delayTimeout = setTimeout(() => {
            this.getKey = getKey;
        }, DELAY);
    }
    show=false;
    selectdetail(){
       let all= this.template.querySelector('lightning-datatable');
       this.recordId=all.selectedRows[0];
    }

    nameId;
    deleteCand(event){
        // window.clearTimeout(this.delayTimeout);
        let inputField= this.template.querySelector('lightning-datatable');
        this.nameId=[];
        this.nameId=inputField.selectedRows;
        // }
        deleteCand({NameId:this.nameId})
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
     previoustpage(){
         this.beforepage=true;
         this.page=this.page-1;
         if(this.page==0){
             this.beforepage=false;
             this.afterpage=true;
         }
     }
     nextpage(){
        this.beforepage=true;
        let all= this.template.querySelector('lightning-datatable');
        let i=(Number)(Math.floor(all.data.length/10));
        this.page=this.page+1;
        if(i==this.page){
            this.afterpage=false;
        }
     }
}