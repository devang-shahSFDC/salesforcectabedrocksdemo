import { LightningElement, wire, api } from 'lwc';
import getAllContactsWithAccounts from '@salesforce/apex/ContactController.getAllContactsWithAccounts'
export default class ContactAccountsGrid extends LightningElement {
    gridData = []
    @api recordId;
    @api sortBy = 'Name'
    @api sortDirection = 'Ascending'
    @api noOfRelatedAccounts = 1
    @api noOfItems = 30


    @wire(getAllContactsWithAccounts, {accountId:'$recordId'})
    allContactsWithAccountsResult({data, error}){
        if(data){  
            console.log(data) 
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


    formatGridData(result){ 

        this.gridData = result.map(item=>{
            const {accounts, ...contacts} = item
            return {...contacts, "_children":accounts}
        })
        console.log('***'+ this.gridData)
      
        this.gridData.sort((a, b) => console.log(b.noOfRelatedAccounts));
        
        if(this.sortBy === 'Number Of Accounts' && this.sortDirection === 'Descending'){
            this.gridData.sort((a, b) => {
                return b.noOfRelatedAccounts - a.noOfRelatedAccounts;
            });            
        }

        if(this.sortBy === 'Number Of Accounts' && this.sortDirection === 'Ascending'){
            this.gridData.sort((a, b) => {
                return a.noOfRelatedAccounts - b.noOfRelatedAccounts;
            });                 
        }

        if(this.sortBy === 'Name' && this.sortDirection === 'Ascending'){
            this.gridData.sort((a, b) => {
                var nameA = a.Name.toLowerCase(), nameB = b.Name.toLowerCase()
                if (nameA < nameB) //sort string ascending
                    return -1 
                if (nameA > nameB)
                    return 1
                return 0 //default return value (no sorting)
            });
            console.log('name sorting asc')
        }

        if(this.sortBy === 'Name' && this.sortDirection === 'Descending'){
            this.gridData.sort((a, b) => {
                var nameA = a.Name.toLowerCase(), nameB = b.Name.toLowerCase()
                if (nameA > nameB) //sort string ascending
                    return -1 
                if (nameA < nameB)
                    return 1
                return 0 //default return value (no sorting)
            });
            console.log('name sorting desc')
        }

        console.log('gg1919*' + this.gridData.length) 
        console.log('this.noOfItems*' + this.noOfItems)    
        if(this.gridData.length > this.noOfItems){
            let elemsToDelete = this.gridData.length - this.noOfItems;
            // Using the splice() method to remove from
            // the last nth index for n elements
            this.gridData.splice(this.gridData.length - elemsToDelete,  elemsToDelete);
        }
    }
}