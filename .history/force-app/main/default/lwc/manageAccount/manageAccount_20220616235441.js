import { LightningElement, api, wire } from "lwc";
import getRecord from '@salesforce/apex/DynamicQueryController.getRecord'
//import the reference to fields
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import RATING_FIELD from "@salesforce/schema/Account.Rating";

export default class manageAccount extends LightningElement {
  @api recordId;

  @wire(getRecord, {recordId: '$recordId'})
  wiredAccount({ error, data }) {
      console.log('get AccountId');
      if (data) {
        console.log(data[0]);
          this.recordId = data[0].AccountId;
      } else if (error) {
          console.log('Something went wrong:', error);
      }
  }

  //create an array type property	
  fields = [NAME_FIELD, INDUSTRY_FIELD, RATING_FIELD];
}