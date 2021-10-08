import { LightningElement } from 'lwc';
import TRAILHEAD_LOGO from '@salesforce/resourceUrl/showlogo';
import greeting from '@salesforce/label/c.this_is_a_sample';
import Id from '@salesforce/user/Id';

export default class ShowLogo extends LightningElement {
    trailheadLogoUrl = TRAILHEAD_LOGO;
    label = {
        greeting,
    };
    userId = Id;
}