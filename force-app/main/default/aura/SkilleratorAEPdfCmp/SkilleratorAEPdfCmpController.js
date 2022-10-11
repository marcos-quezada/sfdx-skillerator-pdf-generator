({
    init: function (component, event, helper) {              
    var recordId = component.get('v.recordId');        
    var evt = $A.get("e.force:navigateToSObject");        
    evt.setParams({            
        recordId: recordId,
      	slideDevName: "related"
    });   
        
    let action = component.get('c.doCallout');
        action.setParams({accountId : component.get('v.recordId')});
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.loaded', true)
                evt.fire();
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);   
	}
})