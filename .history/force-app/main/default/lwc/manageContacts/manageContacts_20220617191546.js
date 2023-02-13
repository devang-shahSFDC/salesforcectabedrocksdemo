import { LightningElement, wire, api } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';

export default class ApexWireMethodToProperty extends LightningElement {
    @api recordId;
    
    @wire(getContactList) contacts;
}