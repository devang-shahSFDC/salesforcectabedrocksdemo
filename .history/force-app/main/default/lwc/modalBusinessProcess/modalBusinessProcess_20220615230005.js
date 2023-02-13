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

                    let viewAccountHierarchy = 'View ' +  conts[key]; + ' Hierarchy';
                    let viewAccountHierarchyKey = 'View' +  conts[key]; + 'Hierarchy';
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
    
    showModalPopup() {
        console.log('gg19');
        this.showModal = true;
        if(key == 'Account') {
            this.modalHeader = 'Management Account';
        } else if(key == 'ViewAccountHierachy') {
            this.modalHeader = 'View Account  Hierachy';
        } else if(key == 'Attachment') {
            this.modalHeader = 'Management Attachment';
        } else if(key == 'Contact') {
            this.modalHeader = 'Management Contact';
        } else if(key == 'Contract') {
            this.modalHeader = 'Management Contract';
        } else {
        }            
    }
}