import { LightningElement } from 'lwc';
import {fetchDataHelper} from './fetchDataHelper';

const columns = [
    { label: 'name', fieldName: 'name' },
    { label: 'phone', fieldName: 'phone' }
];

export default class BasicDatatable extends LightningElement {
    data = [];
    columns = columns;
    add() {
        const data1 = fetchDataHelper();
        this.data = this.data.concat(data1);
        console.log(this.data)
    }
}
