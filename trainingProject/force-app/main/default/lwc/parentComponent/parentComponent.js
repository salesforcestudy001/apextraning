import { api, LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
  contacts = [
        {
            idd : 1,
            name : 'a',
        },
        {
            idd : 2,
            name : 'b',
        },
        {
            idd : 3,
            name : 'c',
        }
    ];
    
}