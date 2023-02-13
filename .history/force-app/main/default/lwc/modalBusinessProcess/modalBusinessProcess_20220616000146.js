import { LightningElement, wire, track, api } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import fetchRelatedObjectsMap from '@salesforce/apex/RelatedObjectsController.fetchRelatedObjectsMap';

export default class ModalBusinessProcess extends LightningElement {

    @api recordId;
    @track showModal = false;
    @track showNegativeButton;
    @track showPositiveButton = true;
    @track positiveButtonLabel = 'Close';
    @track mapRelatedObjectsData= [];
    @track modalHeader = '';
    @track modalHeader = '';
    @track manageAccountVisible = false;
    @track viewAccountHierachyVisible = false;
    @track manageContactsVisible = false;
    @track manageContractVisible = false;
    @track manageAttachmentVisible = false;

    @wire(fetchRelatedObjectsMap, { recordId: '$recordId'})
    wiredResult(result) { 
        if (result.data) {
            //mapData = [];
            var conts = result.data;
            console.log('gg1');
            for(var key in conts){
                console.log(key);
                if(key == 'Account') {
                    let manageAccount = 'Manage ' +  conts[key];
                    this.mapRelatedObjectsData.push({value:manageAccount, key:key}); //Here we are creating the array to show on UI.

                    let viewAccountHierarchy = 'View ' +  conts[key] + ' Hierarchy';
                    let viewAccountHierarchyKey = 'View' +  conts[key] + 'Hierarchy';
                    console.log('***'+ viewAccountHierarchyKey);
                    this.mapRelatedObjectsData.push({value:viewAccountHierarchy, key:viewAccountHierarchyKey}); //Here we are creating the array to show on UI.
                } else if(key == 'Attachment') {
                        let manageAccount = 'Manage ' +  conts[key];
                        this.mapRelatedObjectsData.push({value:manageAccount, key:key}); //Here we are creating the array to show on UI.
                } else {
                    this.mapRelatedObjectsData.push({value:conts[key], key:key}); //Here we are creating the array to show on UI.
                }
                
                
            }
        }
    }


    closeModal() {
        this.showModal = false;
    }
    
    showModalPopup(event) {
        console.log('gg19');
        console.log(event.currentTarget.id);
        let key = event.currentTarget.id;
        
        this.showModal = true;
        this.manageAccountVisible = false;
        this.viewAccountHierachyVisible = false;
        this. manageContactsVisible = false;
        this.manageContractVisible = false;
        this.manageAttachmentVisible = false;

        if(key == 'Account') {

            this.modalHeader = 'Manage Account';
            this.manageAccountVisible = true;
   
        } else if(key == 'ViewAccountHierarchy-116') {

            this.modalHeader = 'View Account  Hierachy';
            this.viewAccountHierachyVisible = true;
         
        } else if(key == 'Attachment-116') {
            console.log('gg191');
            console.log(event.currentTarget.id);
            this.modalHeader = 'Manage Attachment';
            this.manageAttachmentVisible = true;
            
        } else if(key == 'Contact') {

            this.modalHeader = 'Manage Contacts';
            this.manageContactsVisible = true;            
            
        } else if(key == 'Contract') {

            this.modalHeader = 'Manage Contract';
            this.manageContractVisible = true;

        } else {

            this.modalHeader = ''
        }            
    }
}