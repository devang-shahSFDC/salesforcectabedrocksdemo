import { LightningElement, wire } from 'lwc';
import { getRecordUi } from 'lightning/uiRecordApi';

export default class manageContacts extends LightningElement {
  @wire(getRecordUi, { recordIds: '0018d000008eWmGAAU', childRelationships: "Account.Contacts" })
  myRecord;
  console.log(myRecord);
}