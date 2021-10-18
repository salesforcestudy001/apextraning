import { LightningElement } from 'lwc';
import TRAILHEAD_LOGO from '@salesforce/resourceUrl/salesforcelogo';
import greeting from '@salesforce/label/c.show_label';


 
 
export default class ShowPicture extends LightningElement {
    trailheadLogoUrl = TRAILHEAD_LOGO;
    label = greeting;
}