import { LightningElement ,wire ,track} from 'lwc';
import TRAILHEAD_LOGO from '@salesforce/resourceUrl/aimage';
import getUserList from '@salesforce/apex/loginHomeworkCtrl.getUserList';
import insertuser from '@salesforce/apex/loginHomeworkCtrl.insertuser';
export default class LoginHomework extends LightningElement {

    imgurl = TRAILHEAD_LOGO;
    
    @wire(getUserList) userList;
    @track userNames;

    FirstName;
    LastName;
    Email;
    Roles;
    Company;
    Countries;
    PostalCode;
    UserName;
    
    // getUserNames(){
    //     // console.log("test01");
    //     // console.log(JSON.stringify(this.userList.data));
    //     for(let i=0;i<this.userList.data.length;i ++){
    //         console.log(this.userList.data[i].this.userList.data.length);
    //         this.userNames.push(this.userList.data[i].Username__c);
    //         console.log("1");
    //     }
    // }

    signin(){
        // console.log("registerRun");
        let flag = false;
         
        for (let i = 0; i < this.userList.data.length; i++) {
            if(this.UserName == this.userList.data[i].Username__c){
                alert(" Signin Failed!");
                flag = true;
            }
        }
        console.log('before flag');
        if(flag == false){
            console.log('flag');
            insertuser({firstname:this.FirstName, 
                        lastname:this.LastName, 
                        company:this.Company, 
                        countries:this.Countries, 
                        email:this.Email, 
                        postalcode:this.PostalCode, 
                        roles:this.Roles, 
                        username:this.UserName}); 
                alert("Signin Successful!");
        }
    }

    firstnamehandleChange(event) {
        this.FirstName = event.detail.value;
    }

    lastnamehandleChange(event) {
        this.LastName = event.detail.value;
    }

    emailhandleChange(event) {
        this.Email = event.detail.value;
    }

    companyhandleChange(event) {
        this.Company = event.detail.value;
    }

    postalcodehandleChange(event){
        this.PostalCode = event.detail.value;
    }

    usernamehandleChange(event){
        this.UserName = event.detail.value;
    }

    // login action
    // login(){

    // }

    // role's lists method
    rolevalue;
    get role() {
        return [
            { label: ' ', value: 'Your job role' },
            { label: 'Developer', value: 'Developer' },
            { label: 'Architect/CTO', value: 'Architect/CTO' },
            { label: 'IT Manager/Executive', value: 'IT Manager/Executive' },
            { label: 'Bussiness Manager/Executive', value: 'Bussiness Manager/Executive' },
        ];
    }

    rolehandleChange(event) {
        this.rolevalue = event.detail.value;
        // this.rolevalue = event.target.value;
    }

    // country's lists method
    countryvalue;
    get country() {
        return [
            { label: ' ', value: 'Select Country' },
            { label: 'China', value: 'China' },
            { label: 'USA', value: 'USA' },
            { label: 'Canada', value: 'Canada' },
            { label: 'Japana', value: 'Japana' },
            { label: 'Korea', value: 'Korea' },
        ];
    }

    countryhandleChange(event) {
        this.countryvalue = event.detail.value;
        // this.countryvalue = event.target.value;
    }
}