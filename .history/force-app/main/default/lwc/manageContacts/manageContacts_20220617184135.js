import { LightningElement, api, wire } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';
export default class WireGetRelatedListRecords extends LightningElement {
    error;
    records;
    @api recordId;

    @wire(getRelatedListRecords, {
        parentRecordId: '0018d000008eWmGAAU',
        relatedListId: 'Contacts',
        fields: ['Contact.Id','Contact.Name']      
    })listInfo({ error, data }) {
        console.log('gg1 contacts');
        if (data) {
            this.records = data.records;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.records = undefined;
        }
    }
}