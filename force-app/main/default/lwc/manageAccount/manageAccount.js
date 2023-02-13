import { LightningElement, api, wire, track } from "lwc";
//import the reference to fields
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import RATING_FIELD from "@salesforce/schema/Account.Rating";

export default class manageAccount extends LightningElement {
    @api recordId;

    //create an array type property	
    fields = [NAME_FIELD, INDUSTRY_FIELD, RATING_FIELD];
}