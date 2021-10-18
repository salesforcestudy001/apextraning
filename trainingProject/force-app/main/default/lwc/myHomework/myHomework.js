import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import TRAILHEAD_LOGO from '@salesforce/resourceUrl/salesforcepicture';


export default class MyHomework extends LightningElement {
    trailheadLogoUrl = TRAILHEAD_LOGO;


    @api recordId;
    fields=["First_Name__c","Last_Name__c","Email__c","Role__c","Company__c","Country__c","Postal_Code__c","Username__c"];
    handleAccountCreated(event){
        window.open('https://d5g00000a3upveaz-dev-ed.lightning.force.com/lightning/r/homework__c/'+event.detail.id+'/view','_blank');
    }
    handleError(event){

        console.log(event.detail);

        this.dispatchEvent(

            new ShowToastEvent({

                title: 'Error creating record',

                message: "用户名以重复 请重新设置",

                variant: 'error',

            }),

        );

    }
}