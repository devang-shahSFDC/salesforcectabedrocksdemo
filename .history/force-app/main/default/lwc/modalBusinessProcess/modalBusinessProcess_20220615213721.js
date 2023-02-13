import { LightningElement, wire, track, api } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import fetchRelatedObjectsMap from '@salesforce/apex/RelatedObjectsController.fetchRelatedObjectsMap';

export default class ModalBusinessProcess extends LightningElement {

    @api recordId;
    @track mapRelatedObjectsData= [];

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
                } else {
                    this.mapRelatedObjectsData.push({value:conts[key], key:key}); //Here we are creating the array to show on UI.
                }
                
                
            }
        }
    }
}