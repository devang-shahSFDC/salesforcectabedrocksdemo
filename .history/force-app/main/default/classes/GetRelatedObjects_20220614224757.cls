public class GetRelatedObjects {

    public static map<string,string> getRelatedObjectList(string objectName){
    
        map<string,string> relatedObjectsMap = new map<string,string>();
        list<Schema.Childrelationship> relatedObjectsList = Schema.getGlobalDescribe().get(objectName).getdescribe().getChildRelationships();
        
        List<Related_Object__mdt> objectConfigurations = getRelatedObjectConfigurations(objectName);

        for (Schema.Childrelationship relatedObject : relatedObjectsList) {

            if()

            if(relatedObject.getChildSObject().getDescribe().isUpdateable()
                &&
                relatedObject.getChildSObject().getDescribe().getKeyPrefix()!=null
                &&
                !relatedObject.getChildSObject().getDescribe().isCustomSetting()
                &&
                relatedObject.getChildSObject().getDescribe().isCreateable()
            ){
                    relatedObjectsMap.put(relatedObject.getChildSObject().getDescribe().getName(),relatedObject.getChildSObject().getDescribe().getLabel());
            }
            
        }
        return relatedObjectsMap;
    }

    public static Set<String> getActiveRelatedObjects(string objectName) {
        List<Related_Object__mdt> allConfigurations = Related_Object__mdt.getall().values();
        Set<String> activeRelatedObjects = new Set<String>();
        for(Related_Object__mdt ro :objectConfigurations){
            if(ro.Object_Name__c.equalsIgnoreCase(objectName) && ro.Display_Manage_Button__c == true){
                activeRelatedObjects.add(ro);
            }
        }
        return activeRelatedObjects;
    }
}