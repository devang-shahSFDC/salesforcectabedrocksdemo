public with sharing class DynamicQueryController {

    @AuraEnabled(cacheable=true)
    public static list<sobject> getRecord(Id recordId, string cols){
        String objectName = recordId.getSObjectType().getDescribe().getName();
        string condition = 'Id = \'' + String.escapeSingleQuotes(recordId)+'\'
        string query = 'select '+String.escapeSingleQuotes(cols)+' from '+objectName+' where '+ condition;
        System.Debug(query);
        list<sobject> records = Database.query(query);
        return records;
    }

}
