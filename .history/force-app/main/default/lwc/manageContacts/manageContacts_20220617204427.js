import { LightningElement, wire, api } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';

export default class manageContacts extends LightningElement {
    @api recordId;

    @wire(getContactList,{recordId: '0018d000008eWmGAAU'}) contacts;

    handleSelect(event) {
        // 1. Prevent default behavior of anchor tag click which is to navigate to the href url
        //event.preventDefault();
        // 2. Create a custom event that bubbles. Read about event best practices at http://developer.salesforce.com/docs/component-library/documentation/lwc/lwc.events_best_practices
        // const selectEvent = new CustomEvent('contactselect', {
        //     detail: { contactId: event.currentTarget.dataset.contactId }
        // });
        // 3. Fire the custom event
        //this.dispatchEvent(selectEvent);
    }
}