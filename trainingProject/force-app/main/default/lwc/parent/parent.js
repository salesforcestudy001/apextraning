import { LightningElement } from 'lwc';

export default class Parent extends LightningElement {
    handleClickLogin() {
        // console.log(111)
        // this.template.querySelector('c-video-player').play();
        this.template.querySelector('c-child').login();
    }
    
}