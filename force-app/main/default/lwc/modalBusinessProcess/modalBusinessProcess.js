import { LightningElement, wire, track, api } from "lwc";

// Import Apex
import fetchRelatedObjectsMap from '@salesforce/apex/RelatedObjectsController.fetchRelatedObjectsMap';
import getRecordData from '@salesforce/apex/DynamicQueryController.getRecordData'
export default class ModalBusinessProcess extends LightningElement {

    @api recordId;
    @track objectId;
    @track showModal = false;
    @track showNegativeButton;
    @track showPositiveButton = true;
    @track positiveButtonLabel = 'Close';
    @track mapRelatedObjectsData= [];
    @track modalHeader = '';
    @track manageAccountVisible = false;
    @track viewAccountHierachyVisible = false;
    @track manageContactsVisible = false;
    @track manageContractVisible = false;
    @track manageAttachmentVisible = false;
    @track manageTasksVisible = false;

    @wire(fetchRelatedObjectsMap, { recordId: '$recordId'})
    wiredResult(result) { 
        if (result.data) {
            //mapData = [];
            var conts = result.data;
          
            for(var key in conts){
               
                if(key === 'Account') {
                    let manageAccount = 'Manage ' +  conts[key];
                    this.mapRelatedObjectsData.push({value:manageAccount, key:key});

                    let viewAccountHierarchy = 'View ' +  conts[key] + ' Hierarchy';
                    let viewAccountHierarchyKey = 'View' +  conts[key] + 'Hierarchy';
                    console.log('***'+ viewAccountHierarchyKey);
                    this.mapRelatedObjectsData.push({value:viewAccountHierarchy, key:viewAccountHierarchyKey}); 
                } else {
                    let manageOther = 'Manage ' +  conts[key];
                    this.mapRelatedObjectsData.push({value:manageOther, key:key}); 
                }
            }            
        }
    }

    @wire(getRecordData,{recordId: '$recordId',  cols: 'AccountId'}) 
    wiredAccounts ({ error, data }) {
        if (data) {
            this.objectId = data[0].AccountId;
            console.log('****' + this.objectId);
        } else if (error) {
            console.log('error');
        }
    }

    closeModal() {
        this.showModal = false;
    }
    
    showModalPopup(event) {
      
        console.log(event.target.dataset.name);      
        let key = event.target.dataset.name;
        this.showModal = true;
        this.manageAccountVisible = false;
        this.viewAccountHierachyVisible = false;
        this.manageContactsVisible = false;
        this.manageContractVisible = false;
        this.manageAttachmentVisible = false;
        this.manageTasksVisible = false;

        if(key === 'Account') {
            this.modalHeader = 'Manage Account';
            this.manageAccountVisible = true;
   
        } else if(key === 'ViewAccountHierarchy') {
            this.modalHeader = 'View Account Hierachy';
            this.viewAccountHierachyVisible = true;
         
        } else if(key === 'Attachment') {           
            this.modalHeader = 'Manage Attachment';
            this.manageAttachmentVisible = true;
            
        } else if(key === 'Contact') {
            this.modalHeader = 'Manage Contacts';
            this.manageContactsVisible = true;            
            
        } else if(key === 'Task') {
            this.modalHeader = 'Create Task';
            this.manageTasksVisible = true;

        } else {
            this.modalHeader = ''
        }            
    }
}