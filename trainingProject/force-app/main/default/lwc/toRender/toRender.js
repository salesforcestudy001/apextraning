import UserPreferencesNewLightningReportRunPageEnabled from '@salesforce/schema/User.UserPreferencesNewLightningReportRunPageEnabled';
import { LightningElement } from 'lwc';
import { selData } from './selData';
import greeting from '@salesforce/label/c.Name';
import greeting2 from '@salesforce/label/c.myPhone';

const columns = [
    {label:greeting,fieldName:'name'},
    {label:greeting2,fieldName:'phone',type:'phone'}
];

export default class ToRender extends LightningElement {
    data = [{name:'david',phone:'123'}];
    columns = columns;
    handleClick()
    {
        var conData = selData();
        this.data = this.data.concat(conData);
        // console.log('添加一条数据')

    }
}