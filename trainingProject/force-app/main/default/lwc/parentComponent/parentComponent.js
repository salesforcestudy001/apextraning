/*
 * @Author: your name
 * @Date: 2021-09-27 14:53:45
 * @LastEditTime: 2021-09-27 16:26:00
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \trainingProject\force-app\main\default\lwc\parentComponent\parentComponent.js
 */
import { LightningElement,api } from 'lwc';

export default class ParentComponent extends LightningElement {
    contact001=new contact(1,"Amy Taylor","VP of Engineering");
    contact002=new contact(1,"Michael Jones","VP of Sales");
    contact003=new contact(1,"Jennifer Wu","CEO");
    @api contacts=[this.contact001,this.contact002,this.contact003];

}
function contact(id,name,title) {
    this.Id=id;
    this.Name=name;
    this.Title=title;
}
