public class GetRelatedObjects {

    public static map<string,string> getRelatedObjectList(string objectName){
    
        map<string,string> relatedObjectsMap = new map<string,string>();
        list<Schema.Childrelationship> relatedObjectsList = Schema.getGlobalDescribe().get(objectName).getdescribe().getChildRelationships();
        
        Set<String> activeRelatedObjects = getActiveRelatedObjects(objectName);

        for (Schema.Childrelationship relatedObject : relatedObjectsList) {

            if(!activeRelatedObjects.contains(relatedObject.getChildSObject().getDescribe().getName())){
                continue;
            }

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

        for(Schema.SobjectField strFld: Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap().Values()){
            if(strFld.getDescribe().getType() == Schema.DisplayType.REFERENCE){
                
                if(!activeRelatedObjects.contains(strFld.getDescribe().getReferenceTo())){
                    continue;
                }
                system.debug('==parent object='+strFld.getDescribe().getReferenceTo());
                relatedObjectsMap.put(strFld.getDescribe().getReferenceTo(), strFld.getDescribe().getReferenceTo());
            }
        }


        return relatedObjectsMap;
    }

    public static Set<String> getActiveRelatedObjects(string objectName) {
        List<Related_Object__mdt> allConfigurations = Related_Object__mdt.getall().values();
        Set<String> activeRelatedObjects = new Set<String>();
        for(Related_Object__mdt ro :allConfigurations){
            if(ro.Object_Name__c.equalsIgnoreCase(objectName) && ro.Display_Manage_Button__c == true){
                activeRelatedObjects.add(ro.Related_Object_Name__c);
            }
        }
        return activeRelatedObjects;
    }
}