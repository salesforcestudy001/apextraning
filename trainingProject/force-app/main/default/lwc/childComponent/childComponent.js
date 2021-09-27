import { LightningElement,api} from 'lwc';

export default class ChildComponent extends LightningElement {
    @api namee;
    @api phonee;
    @api emaill;
}