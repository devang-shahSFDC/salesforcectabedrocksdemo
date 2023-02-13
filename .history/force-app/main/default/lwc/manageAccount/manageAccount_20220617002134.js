import { LightningElement, api, wire, track } from "lwc";
import getRecord from '@salesforce/apex/DynamicQueryController.getRecord'
//import the reference to fields
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import RATING_FIELD from "@salesforce/schema/Account.Rating";

export default class manageAccount extends LightningElement {
    @api recordId;
    @api ObjectId;
    @track error;

    @wire(getRecord, {recordId: '$ObjectId',  cols: 'AccountId'})
    wiredResult({data, error}){ 
        this.recordId= '0018d000008eWmGAAU'
        if(data){ 
            console.log(data)
        }
        if(error){ 
            console.log(error)
        }
    }

    //create an array type property	
    fields = [NAME_FIELD, INDUSTRY_FIELD, RATING_FIELD];
}