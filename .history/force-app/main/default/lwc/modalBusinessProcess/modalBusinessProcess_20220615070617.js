import { LightningElement, wire, track, api } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import fetchRelatedObjectsMap from '@salesforce/apex/RelatedObjectsController.fetchRelatedObjectsMap';

export default class ModalBusinessProcess extends LightningElement {

    @api recordId;
    @track mapRelatedObjectsData= [];

    @wire(fetchRelatedObjectsMap)
    wiredResult(result) { 
        if (result.data) {
            //mapData = [];
            var conts = result.data;
            for(var key in conts){
                this.mapRelatedObjectsData.push({value:conts[key], key:key}); //Here we are creating the array to show on UI.
            }
        }
    }
}