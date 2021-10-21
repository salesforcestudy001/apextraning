import { LightningElement ,api} from 'lwc';
import TRAILHEAD_LOGO from '@salesforce/resourceUrl/showsalesforce';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class mySalesforceLogin extends LightningElement {

    trailheadLogoUrl = TRAILHEAD_LOGO;
    
    @api recordId;

    handleReset(event){
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
     }
    handleError(event){
        console.log(event.detail);
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error creating record',
                message: event.detail.message,
                variant: 'error',
            }),
        );
    }
    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: "MySalesforce created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
        window.open('https://d5g00000a3ubneab-dev-ed.lightning.force.com/lightning/r/mysalesuser__c/'+event.detail.id+'/view','_blank');
    }
}