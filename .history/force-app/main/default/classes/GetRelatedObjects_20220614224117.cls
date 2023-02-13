public class GetRelatedObjects {

    public static map<string,string> getRelatedObjectList(string objectName){
    
        map<string,string> relatedObjectsMap = new map<string,string>();
        list<Schema.Childrelationship> relatedObjectsList = Schema.getGlobalDescribe().get(objectName).getdescribe().getChildRelationships();
        
        for (Schema.Childrelationship relatedObject : relatedObjectsList) {
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

    public static List<Related_Object__mdt> getRelatedObjectConfigurations(string objectName) {
        List<Related_Object__mdt> allConfigurations = Related_Object__mdt.getall().values();
        List<Related_Object__mdt> objectConfigurations = new List<Related_Object__mdt>();
        for(Related_Object__mdt ro :objectConfigurations){
            if(ro.Object_Name__c.equalsIgnoreCase(objectName)){
                objectConfigurations.add(ro);
            }
        }
        return objectConfigurations;
    }
}