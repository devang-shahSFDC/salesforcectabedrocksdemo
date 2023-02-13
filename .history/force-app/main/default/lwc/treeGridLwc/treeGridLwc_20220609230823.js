import { LightningElement, wire, api } from 'lwc';
import allAccountsWithContact from '@salesforce/apex/AccountContact.allAccountsWithContact'
import allContactsWithAccounts from '@salesforce/apex/AccountContact.allContactsWithAccounts'
export default class TreeGridLwc extends LightningElement {
    gridData = []
    @api sortBy = 'Name'
    @api sortDirection = 'Ascending'
    @api noOfRelatedAccounts = 5

    @wire(allContactsWithAccounts, {recordId:'0018d000008jlQlAAI', sortBy:'Name', noOfRelatedAccounts:5})
    allContactsWithAccountsResult({data, error}){
        console.log('gg1');
        console.log(this.sortBy); 
        console.log(this.sortDirection);
        console.log(this.noOfRelatedAccounts); 
        console.log('gg1');      
        if(data){  
            console.log(data)  
            //this.gridData = data        
            this.formatGridData(data)
        }
        if(error){
            console.error(error)
        }
    }

    /***Columns */
    gridColumns=[
        {
            label:'Name',
            fieldName:'Name',
            type:'text'
        },
        {
            label:'Phone',
            fieldName:'Phone',
            type:'text'
        },
        {
            label:'Account Website',
            fieldName:'Website',
            type:'url',
            typeAttributes:{
                target:'_blank'
            }
        }
    ]

    dummyData = [
        {
            Name: 'Salesforce',
            Email: 'Salesforce@gmail.com',
            Website: 'salesforcetroop.com'
        },
        {
            Name: 'Troop',
            Email: 'troop@gmail.com',
            Website: 'salesforcetroop.com'
        }
    ]

    formatGridData(result){
        
        // this.gridData = result.map(item=>{
        //     const {Contacts, ...accounts} = item
        //     const updatedContact = Contacts.map(cont=>{
        //         return {...cont, "_children":this.dummyData}
        //     })
        //     return {...accounts, "_children":updatedContact}
        // })


        this.gridData = result.map(item=>{
            const {accounts, ...contacts} = item
            return {...contacts, "_children":accounts}
        })
        console.log(this.gridData)

        console.log('gg19')
        this.gridData.sort((a, b) => console.log(b.noOfRelatedAccounts));
        
        if(sortBy === 'Number Of Accounts' && sortDirection === 'Ascending'){
            this.gridData.sort((a, b) => {
                return b.noOfRelatedAccounts - a.noOfRelatedAccounts;
            });
            console.log('gg19')
        }

        if(sortBy === 'Number Of Accounts' && sortDirection === 'Ascending'){
            this.gridData.sort((a, b) => {
                return a.noOfRelatedAccounts - b.noOfRelatedAccounts;
            });
            console.log('gg1919')            
        }


    }

}