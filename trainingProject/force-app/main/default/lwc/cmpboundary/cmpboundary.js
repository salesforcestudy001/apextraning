import { LightningElement } from 'lwc';

export default class Cmpboundary extends LightningElement {
    error;
    stack;
    errorCallback(error, stack) {
        this.error = error;
    }
}