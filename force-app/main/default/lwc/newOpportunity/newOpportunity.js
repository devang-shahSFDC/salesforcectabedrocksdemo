import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
 
export default class NewOpportunity extends NavigationMixin(LightningElement) {
    @api accId;
    @api accountName;

    handleChange(event) {
        this.selectedValue = event.detail.value;
    }

    navigateToNewOpportunityWithDefaults() {
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var hh = String(today.getHours()).padStart(2, '0');
        var min = String(today.getMinutes()).padStart(2, '0');
        var yyyy = today.getFullYear();
        today = dd +  mm +  yyyy + ' ' + hh + ':' + min;
        // 22/02/2023- prj gg1-1005 Change to opportunity name
        const defaultValues = encodeDefaultFieldValues({
            Name: this.accountName + '*****' + today
        });

        console.log(defaultValues);
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Opportunity',
                actionName: 'new'
            },
            state: {
                nooverride: '0',
                defaultFieldValues: defaultValues,
                recordTypeId: this.recordTypeValue
            }
        });
    }

    renderedCallback(){
        console.log('****'+this.accId);
        this.navigateToNewOpportunityWithDefaults();
   }   
}