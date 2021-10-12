import { LightningElement } from 'lwc';

export default class Boundary extends LightningElement {
    error;
    stack;
    errorCallback(error, stack) {
        this.error = error;
        this.stack = stack;
    }
}