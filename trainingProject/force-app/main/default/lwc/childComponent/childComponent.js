import { LightningElement,api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api temp;
    handlePlay() {
        console.log(this.temp.Name);
        this.temp.Name = "change";
        // console.log("123");
    }
}