import { LightningElement, api, wire, track } from "lwc";
import getRecord from '@salesforce/apex/DynamicQueryController.getRecord'
//import the reference to fields
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import RATING_FIELD from "@salesforce/schema/Account.Rating";

export default class manageAccount extends LightningElement {
  @api recordId;
  @track error;

  @wire(getRecord, {recordId: '$recordId', cols: 'AccountId'})      
    wiredAccount({ error, data }) {
        console.log('get AccountId*');
        if (data) {
            console.log(data);
            //this.recordId = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.record = undefined;
        }
    }

  //create an array type property	
  fields = [NAME_FIELD, INDUSTRY_FIELD, RATING_FIELD];
}