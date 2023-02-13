import { createElement } from 'lwc';
import MapsInLwcDemo from 'c/mapsInLwcDemo'
import getCompanyHeadquartersAccount from '@salesforce/apex/AccountController.getCompanyHeadquartersAccount'

describe('maps-in-lwc-demo testing', ()=> {
    beforeEach(()=>{
        const element = createElement('c-maps-in-lwc-demo', {
            is: MapsInLwcDemo
        })
        DocumentFragment.body.appendChild(element)
    })

    it("renders size recrods",  ()=>{
        
    })

})