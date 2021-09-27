import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    contacts = [
        {
            Id: 1,
            Name: 'China',
            Title: '111',
        },
        {
            Id: 2,
            Name: 'America',
            Title: '222',
        },
        {
            Id: 3,
            Name: 'Japan',
            Title: '333',
        },
    ];
}