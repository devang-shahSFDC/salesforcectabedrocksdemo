import { LightningElement, wire, api } from 'lwc';
import getCompanyHeadquartersAccount from '@salesforce/apex/AccountController.getCompanyHeadquartersAccount'
export default class MapsInLwcDemo extends LightningElement {

    mapMarkers=[]
    markersTitle="Accounts Location"
    zoomLevel=5   

    @wire(getCompanyHeadquartersAccount)
    wireHandler({data, error}){
        if(data){
            console.log(JSON.stringify(data))
            this.formatResponse(data)
        }
        if(error){
            console.error(error)
        }
    }

    formatResponse(data){
        this.mapMarkers = data.map(item=>{
      
            return {
                location:{
                    Street:item.BillingStreet || '',
                    City:item.BillingCity ||'',
                    PostalCode: item.BillingPostalCode || '',
                    State: item.BillingState || '',
                    Country: item.BillingCountry || ''
                },
                icon:'utility:salesforce1',
                title: item.Name,
                value: item.Name,
                description: item.Description
            }
        })
        
        this.selectedMarker = this.mapMarkers.length && this.mapMarkers[0].value
        this.zoomLevel = 5 
        console.log(JSON.stringify(this.mapMarkers))
    }
    callMarkerHandler(event){
        this.selectedMarker = event.detail.selectedMarkerValue
    }
}