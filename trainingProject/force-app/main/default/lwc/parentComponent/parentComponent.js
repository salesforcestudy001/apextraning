import { api, LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
  contacts = [
        {
            id : 1,
            name : 'a',
        },
        {
            id : 2,
            name : 'b',
        },
        {
            id : 3,
            name : 'c',
        }
    ];
    
}