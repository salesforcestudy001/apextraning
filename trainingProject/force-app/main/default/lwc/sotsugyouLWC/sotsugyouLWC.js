import { LightningElement ,wire,track} from 'lwc';
import getCandidateList from '@salesforce/apex/sotsugyou.getCandidate';
import selectCandidateByName from '@salesforce/apex/sotsugyou.selectCandidateByName';
import selectCandidate from '@salesforce/apex/sotsugyou.selectCandidate';
import deleteCandidateById from '@salesforce/apex/sotsugyou.deleteCandidateById';




const columns = [
    { label: "CandidateNo", fieldName: 'Name' },
    { label: "名前", fieldName: 'Last_Name__c' },
    { label: '年齢', fieldName: 'Age__c'},
    { label: '電話', fieldName: 'Phone__c'},
    { label: 'メール', fieldName: 'Email__c'},
    { label: '教育', fieldName: 'Education__c'}
];

export default class SotsugyouLWC extends LightningElement {

    tableShow = true;
    editShow = false;

    page = 0;
    cId = "";
    NextButton = true;
    LastButton = false;
    @track dataTable // dataTable
    @track selectRows = []; // 选中的行
    @track Ids = []; // 获取选中的ID
    cans = []; // 增删改查后的返回集合
    pageCans = []; // 获取前几条数据
    objectApiName = "Candidate__c";
    @wire(getCandidateList,{}) candidates;
    columns = columns;



    // 编辑数据
    Edit(){
        if(this.Ids.length > 0){
            // console.log(this.Ids);
            this.cId = this.Ids[0];
        }
        this.editShow = true;
        this.tableShow = true;
        this.Ids = [];
        this.selectRows = [];
           
    }
    // 保存数据
    SavePage(){

        let ld = this.template.querySelectorAll('lightning-datatable');
        console.log(ld[0].data);
        this.editShow = false;
        this.tableShow = true;
        selectCandidate({}).then(result =>{
            this.cans = result;
            this.pageCans = this.getNumberRecord(result,2)[0];
            console.log(this.pageCans);
            ld[0].data = this.pageCans;   
            this.page = 0;
        })
    }

    //模糊查询
    getByName(event){
        this.page = 0;
        let ld = this.template.querySelectorAll('lightning-datatable');
        selectCandidateByName({Last_Name: event.target.value}).then(result => {
            // console.log(result);
            this.cans = result;
            this.pageCans = this.getNumberRecord(result,2)[0];
            console.log(this.pageCans);
            ld[0].data = this.pageCans;
            this.LastButton = false;
        })       
    }
    // 获得选中的ID
    getSelectedName(event){
        // console.log(event.detail.selectedRows);
        this.selectRows = event.detail.selectedRows;
        for(let i = 0;i < event.detail.selectedRows.length;i ++){
            this.Ids.push(event.detail.selectedRows[i].Id);
            console.log(event.detail.selectedRows[i].Id);
        }
    }
    // 根据ID删除
    Delete(){
        this.page = 0;
        let ld = this.template.querySelectorAll('lightning-datatable');
        // console.log("delete");
        // console.log(this.Ids);
        deleteCandidateById({ Ids: this.Ids }).then(result => {
            this.cans = result;
            this.pageCans = this.getNumberRecord(result,2)[0];
            console.log(this.pageCans);
            ld[0].data = this.pageCans;
            this.Ids = [];
            this.selectRows = [];
        })       
    }

    // 下一页
    NextPage(){
        this.LastButton = true;
        if(this.cans.length == 0){
            
            selectCandidate({}).then(result =>{
                this.cans = result;
                console.log("PageBefore: " + this.page);
                let ld = this.template.querySelectorAll('lightning-datatable');
                // console.log(this.cans);
                // console.log(this.getNumberRecord(this.cans,2));
                let cans_temp = this.getNumberRecord(this.cans,2)[this.page + 1];
                // console.log(cans_temp.length);
                ld[0].data = cans_temp;
                this.page = (Number)(this.page) + 1; 
                console.log("PageCurrent: " + this.page);
                if(this.page == this.getNumberRecord(this.cans,2).length - 1){
                    this.NextButton = false;
                }     
            })
        }else{
            console.log("PageBefore: " + this.page);
            let ld = this.template.querySelectorAll('lightning-datatable');
            // console.log(this.cans);
            // console.log(this.getNumberRecord(this.cans,2));
            let cans_temp = this.getNumberRecord(this.cans,2)[this.page + 1];
            // console.log(cans_temp.length);
            ld[0].data = cans_temp;
            this.page = (Number)(this.page) + 1;
            console.log("PageCurrent: " + this.page);  
            if(this.page == this.getNumberRecord(this.cans,2).length - 1){
                this.NextButton = false;
            }        
        }
        
    }

    // 上一页
    LastPage(){
        this.NextButton = true;
        if(this.page >= 1){
            console.log("PageBefore: " + this.page);
            let ld = this.template.querySelectorAll('lightning-datatable');
            // console.log(this.cans);
            let cans_temp = this.getNumberRecord(this.cans,2)[this.page - 1];
            // console.log(cans_temp);
            ld[0].data = cans_temp;
            this.page = (Number)(this.page) - 1;
            console.log("PageCurrent: " + this.page); 
            if(this.page == 0){
                this.LastButton = false;
            }
        }else{
            this.page = 0;      
        }     
    }

    // 取前条
    getNumberRecord(cans,subGroupLength){
        let index = 0;
        let newCans = [];
        while(index < cans.length) {
            newCans.push(cans.slice(index, index += subGroupLength));
        }
        return newCans;
    }








    test01(){
        
        console.log("test01");
        console.log(this.candidates.data);
        let cans = this.getNumberRecord(this.candidates.data,2);
        console.log(cans[0][0].Name);
        
    }

}