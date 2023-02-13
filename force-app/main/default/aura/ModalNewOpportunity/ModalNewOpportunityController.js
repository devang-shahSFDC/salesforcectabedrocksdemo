({
    doInit : function(component, event, helper) {
        console.log('m1');
        var pageReference = component.get("v.pageReference");
        
        var getAccId = pageReference.state.additionalParams;
        if(typeof getAccId !== 'undefined') {          
            getAccId = getAccId.replace('accid=','');
            getAccId = getAccId.substring(0,15);
            console.log('###AccId : '+getAccId);
            component.set("v.accId", getAccId);

            //execute callApexMethod() again after 5 sec each
            // window.setInterval(helper.callApexMethod(component,helper), 
		    // 5000);

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
                    component.set("v.isModalOpen", true);
                    // $A.get('e.force:refreshView').fire();

                }
            });
            $A.enqueueAction(action);
        }
    },
    reInit : function(component, event, helper) {
       $A.get('e.force:refreshView').fire();
    }

 })