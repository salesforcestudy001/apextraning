import UserPreferencesNewLightningReportRunPageEnabled from '@salesforce/schema/User.UserPreferencesNewLightningReportRunPageEnabled';
import { LightningElement } from 'lwc';
import { selData } from './selData';

const columns = [
    {label:'Name',fieldName:'name'},
    {label:'Phone',fieldName:'phone',type:'phone'}
];

export default class ToRender extends LightningElement {
    data = [{name:'david',phone:'123'}];
    columns = columns;
    handleClick()
    {
        var conData = selData();
        this.data = this.data.concat(conData);
        console.log('添加一条数据')

    }
}