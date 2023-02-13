({
    doInit : function(component, event, helper) {
        console.log('Here');
        var pageReference = component.get("v.pageReference");
        
        var getAccId = pageReference.state.additionalParams;
        if(typeof getAccId !== 'undefined') {          
            getAccId = getAccId.replace('accid=','');
            getAccId = getAccId.substring(0,15);
            console.log('###AccId : '+getAccId);
            component.set("v.accId", getAccId);

            var action = component.get('c.getAccountName'); 
            // method name i.e. getEntity should be same as defined in apex class
            // params name i.e. entityType should be same as defined in getEntity method
            action.setParams({
                "accountId" : getAccId
            });
            action.setCallback(this, function(a){
                var state = a.getState(); // get the response state
                if(state == 'SUCCESS') {
                    component.set('v.accName', a.getReturnValue());
                    console.log('###Acc Name : ****'+a.getReturnValue() + '****');
                    // var createRecordEvent = $A.get("e.force:createRecord");
                    // createRecordEvent.setParams({
                    //     "entityApiName": "Opportunity",
                    //     "defaultFieldValues": {
                    //         'Name' : a.getReturnValue()
                    //     }
                    // });
                    // createRecordEvent.fire();
                    // var urlEvent = $A.get("e.force:navigateToURL");
                    // urlEvent.setParams({
                    //   "url": "/006/new"
                    // });
                    // urlEvent.fire();
                }
            });
            $A.enqueueAction(action);
        }
    },
})