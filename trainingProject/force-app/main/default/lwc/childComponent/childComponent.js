/*
 * @Author: your name
 * @Date: 2021-09-27 14:54:00
 * @LastEditTime: 2021-09-27 15:59:24
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \trainingProject\force-app\main\default\lwc\childComponent\childComponent.js
 */
import { LightningElement,api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api contact;

}