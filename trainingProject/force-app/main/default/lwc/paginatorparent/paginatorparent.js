import { LightningElement } from 'lwc';

export default class Paginatorparent extends LightningElement {
    previousHandler(e)
    {
        const theContact  = e.detail;
        console.log('***theContact'+JSON.stringify(theContact));
        
         
       
    }
}