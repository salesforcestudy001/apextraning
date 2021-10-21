import { LightningElement, wire } from 'lwc';
import allCandidate from '@salesforce/apex/inputName.inputName';
import deleteName from '@salesforce/apex/inputName.deleteName';
import candidates from '@salesforce/schema/Candidate__c';
import getCandidate from '@salesforce/apex/inputName.getCandidate';
import getPageRows from '@salesforce/apex/inputName.getPageRows';
import rowsCount from '@salesforce/apex/inputName.rowsCount';

const actions = [
    { label: 'detail', name: 'detail' },
];
const columns = [
    { label: 'CandidateNo', fieldName: 'Name' },
    { label: '名前', fieldName: 'allName__c'},
    { label: '年齢', fieldName: 'age__c'},
    { label: '電話', fieldName: 'Phone__c'},
    { label: 'Email', fieldName: 'Email__c'},
    { label: 'Education', fieldName: 'Education__c' },
    { type: 'action', typeAttributes: { rowActions: actions, menuAlignment: 'left' } }
];

export default class CandidateEdit extends LightningElement {
    
    //初始值
    @wire(getCandidate,{})
    Pages;

    @wire(rowsCount,{ r: '$r',selectName: '$selectName' })
    allRows;

    r = 0;
    page = 0;
    emptyList = [];
    cans;
    apiName = candidates;
    columns = columns;
  
    view = false; //查看
    add = false; //添加
    edit = false; //修改

    value = '';
    selectName = '';
    selectedRows;
    recordId;
    ids;
    lastButton = true;
    nextButton = false;
    

    //添加
    addCandidate(){ this.add = true; }

    //取消
    cancelCreate(){ this.add = false; }

    //编辑
    editRows(){ this.view = false; this.edit = true; }

    //取消查看
    canceEditRows(){ this.view = false; }

    //取消
    handleReset(){ this.add = false; this.edit = false; }

    //新建、编辑
    created(){
        this.add = false;
        this.edit = false;
        deleteName({Ids: this.emptyList}).then(result => {
            console.log("result");
            this.cans = result;
            let ld = this.template.querySelector("lightning-datatable");
            ld.data = this.cans;
            console.log(this.cans);
            this.r = this.r + '1';
        });
        this.page = this.page + 3;
        
    }

    //模糊查询
    selectAllName(e){
        // this.selectName = this.template.querySelector('lightning-input').value;
        this.selectName = e.target.value;
        console.log(e.target.value)
          // 模糊查询
          allCandidate({ selectName: this.selectName}).then((result)=>{
              console.log(result)
            let ld = this.template.querySelector("lightning-datatable");
            ld.data = result;
        })
    }

    //获得选中的值
    getSelectedName(e){
        this.selectedRows = e.detail.selectedRows;
    }

    //删除行
    delectRows(){
        console.log(this.selectedRows[0].Id)
        this.ids = this.selectedRows[0].Id;
        deleteName({Ids: this.selectedRows}).then(result => {
            this.cans = result;
            let ld = this.template.querySelector("lightning-datatable");
            ld.data = this.cans;
            console.log(this.cans);
            this.r = this.r + '1';
        });  
        
    }

    //点击edit
    handleRowAction(event) {
        const action = event.detail.action;
        const row = event.detail.row;
        console.log(row.Id);
        this.view = true;
        this.recordId = row.Id;
     }

     //上一页
     lastPage(){
        //TODO
        this.nextButton = false;
        this.page = (Number)(this.page) - 1;
        console.log(this.selectName)
        getPageRows({page: (Number)(this.page)*3,selectName: this.selectName}).then(res=>{
            console.log(res);
            let rows = this.template.querySelector("lightning-datatable");
            rows.data = res;
        })
      
       console.log(this.allRows.data);
       if((Number)(this.page) == 0){
           this.lastButton = true;
       }
     }

     //下一页
     nextPage(){
         this.lastButton = false;
         this.page = (Number)(this.page) + 1;
         console.log("SelectedName  " + this.selectName);
         getPageRows({page: (Number)(this.page)*3,selectName: this.selectName}).then(res=>{
             console.log(res);
             let rows = this.template.querySelector("lightning-datatable");
             rows.data = res;
         })
        console.log('p'+this.allRows.data);
        if((Number)(this.page + 1) * 3  >= this.allRows.data){
            this.nextButton = true;
        }
     }
}
