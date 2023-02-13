public with sharing class DynamicQueryController {

    @AuraEnabled(cacheable=true)
    public static list<sobject> getRecord(Id recordId, string cols){
        String objectName = recordId.getSObjectType().getDescribe().getName();
       
        string query = 'select '+String.escapeSingleQuotes(cols)+' from '+objectName+' where Id = \'' + String.escapeSingleQuotes(recordId)+'\';
        System.Debug(query);
        list<sobject> records = Database.query(query);
        return records;
    }

}
