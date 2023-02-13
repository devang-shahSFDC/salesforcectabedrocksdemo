/*******************************************************************************************
 * @Name         DynamicQueryController 
 * @Author       Devang Shah <devang.shah@salesforce.com>
 * @Date         18/06/2022
 * @Group        Demo
 * @Description  Class to fetch contacts and accounts releated data
 *******************************************************************************************/
/* MODIFICATION LOG
 * Version   Developer           Date            Description
 *-------------------------------------------------------------------------------------------
 *  1.0      Devang Shah      18/06/2022         Initial Creation                                                   
 *******************************************************************************************/
public with sharing class DynamicQueryController {

    @AuraEnabled(cacheable=true)
    public static list<sobject> getRecordData(Id recordId, string cols){
        String objectName = recordId.getSObjectType().getDescribe().getName();
       
        string query = 'select ' + String.escapeSingleQuotes(cols) + ' from ' + objectName + ' where Id = \'' + String.escapeSingleQuotes(Id.valueOf(recordId)) + '\'';
        System.Debug(query);
        list<sobject> records = Database.query(query);
        return records;
    }

}