public with sharing class DynamicQueryController {

    @AuraEnabled(cacheable=true)
    public static list<sobject> getRecord(Id recordId, string cols){
        String objectName = recordId.getSObjectType().getDescribe().getName();
        string condition = 'Id = ' + recordId;
        string query = 'select '+cols+' from '+objectName+' where '+condition;
        return records;
    }

}
