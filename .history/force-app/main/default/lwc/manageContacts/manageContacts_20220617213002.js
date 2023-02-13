import { LightningElement, api, wire } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';

export default class manageContacts extends LightningElement {
    contacts;
    error;
    @api recordId;

    @wire(getContactList,{recordId: '$recordId'})
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