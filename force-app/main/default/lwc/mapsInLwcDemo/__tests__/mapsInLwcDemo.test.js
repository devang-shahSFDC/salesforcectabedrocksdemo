import { createElement } from 'lwc';
import MapsInLwcDemo from 'c/mapsInLwcDemo'
import { registerApexTestWireAdapter } from '@salesforce/sfdx-lwc-jest';
import getCompanyHeadquartersAccount from '@salesforce/apex/AccountController.getCompanyHeadquartersAccount'

const mockGetCompanyHeadquatersAccountList = require('./data/getCompanyHeadquartersAccount.json');
const getCompanyHeadquartersAccountAdapter = registerApexTestWireAdapter(getCompanyHeadquartersAccount);

describe('maps-in-lwc-demo testing', ()=> {
    beforeEach(()=>{
        const element = createElement('c-maps-in-lwc-demo', {
            is: MapsInLwcDemo
        })
        document.body.appendChild(element)
    })

    it("renders size recrods", ()=>{
        const element = document.querySelector('c-maps-in-lwc-demo')
        getCompanyHeadquartersAccountAdapter.emit(mockGetCompanyHeadquatersAccountList)
        return Promise.resolve().then(()=>{
            const pElem = element.shadowRoot.querySelectorAll('p')
            console.log('****' + pElem[0].textContent);
            console.log('****' + mockGetCompanyHeadquatersAccountList[0].Name);
            expect(pElem[0].textContent).toBe(mockGetCompanyHeadquatersAccountList[0].Name)
        })
    })
})