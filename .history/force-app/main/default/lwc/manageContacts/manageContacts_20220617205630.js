import { LightningElement, api, wire } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';

export default class ApexWireMethodToFunction extends LightningElement {
    contacts;
    error;
    @api recordId;

    @wire(getContactList,{recordId: '0018d000008eWmGAAU'})
    wiredContacts({ error, data }) {
        if (data) {
            console.log(data)
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
    }
}