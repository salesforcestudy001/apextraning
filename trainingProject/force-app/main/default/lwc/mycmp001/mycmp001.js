import { LightningElement} from 'lwc';

export default class Mycmp001 extends LightningElement {
    //@api recordId;
    // @api objectApiName;
    recordId='0015g00000ObCUtAAN';
    // objectApiName='Account';
    fields = ['Name', 'Phone', 'Industry','AnnualRevenue'];
    show = true;
    edit(){
        this.show = !this.show;
    }
}