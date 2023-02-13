/*******************************************************************************************
 * @Name         GlobalUtils 
 * @Author       Devang Shah <devang.shah@salesforce.com>
 * @Date         18/06/2022
 * @Group        Demo
 * @Description  Service class which provides operations needed for creating/updating budget envelopes.
 *******************************************************************************************/
/* MODIFICATION LOG
 * Version   Developer           Date            Description
 *-------------------------------------------------------------------------------------------
 *  1.0      Devang Shah      18/06/2022         Initial Creation                                                   
 *******************************************************************************************/

public with sharing class GlobalUtils {

    private static Map<String, Schema.SObjectType> globalDescribe;
    private static Map<String, Schema.DescribeFieldResult> fieldDescribes = new Map<String, Schema.DescribeFieldResult>();
    private static Map<String, Schema.DescribeSObjectResult> objectDescribes = new Map<String, Schema.DescribeSObjectResult>();
    private static Map<String, String> fieldTypes = new Map<String, String>();


    @AuraEnabled(cacheable=true)
    public static String getCompanyInformation(String name) {
        Company_Information__mdt config = Company_Information__mdt.getInstance(name);
        return config.Value__c;
    }

    public static String getCompanyHeadquartersName() {
        Company_Information__mdt config = Company_Information__mdt.getInstance('Headquarters_Name');
        return config.Value__c;
    }


    @AuraEnabled(cacheable=true)
    public static List<Company_Information__mdt> getCompanyInformations() {
        List<Company_Information__mdt> configurations = Company_Information__mdt.getall().values();        
        return configurations;
    }





    // Returns the global describe. If it's not already loaded in the map: globalDescribe, we retrieve it then place it
    // in this map to have a better performance.
    public static Map<String, Schema.SObjectType> getGlobalDescribe() {
        if(globalDescribe == null) {
            globalDescribe = Schema.getGlobalDescribe(); 
        }
        return globalDescribe;
    }

    // Returns the SObject describe. If it's not already loaded in the map: objectDescribes, we retrieve it then place it
    // in this map to have a better performance.
    public static Schema.DescribeSObjectResult getSObjectDescribe(String apiName) {
        Schema.DescribeSObjectResult SObjectDescribe;
        if(!objectDescribes.containsKey(apiName)) {
            SObjectDescribe =  getGlobalDescribe().get(apiName).getDescribe();
            objectDescribes.put(apiName, SObjectDescribe);
        }
        else {
            SObjectDescribe =  objectDescribes.get(apiName);
        }
        return SObjectDescribe;
    }

    // Returns the field describe. If it's not already loaded in the map: fieldDescribes, we retrieve it then place it
    // in this map to have a better performance.
    public static Schema.DescribeFieldResult getFieldDescribe(String SObjectApiName, String fieldApiName) {
        System.debug('SObjectApiName: ' + SObjectApiName);
        System.debug('fieldApiName: ' + fieldApiName);
        Schema.DescribeFieldResult fieldDescribe;
        String key = SObjectApiName + fieldApiName;
        if(!fieldDescribes.containsKey(key)) {
            fieldDescribe = getSObjectDescribe(SObjectApiName).fields.getMap().get(fieldApiName).getDescribe();
            fieldDescribes.put(key, fieldDescribe);
        }
        else {
            fieldDescribe =  fieldDescribes.get(key);
        }
        System.debug('fieldDescribe: ' + fieldDescribe);
        return fieldDescribe;
    }

    // Returns if the SObject is accessible or not according to the current user permissions.
    public static Boolean isSObjectAccessible(String apiName) {
        return getSObjectDescribe(apiName).isAccessible();
    }

    // Returns if the field is accessible or not according to the current user permissions.
    public static Boolean isFieldAccessible(String SObjectApiName, String fieldApiName) {
        return getFieldDescribe(SObjectApiName, fieldApiName).isAccessible();
    }

    // Returns the plural label of the SObject based on the current user language.
    public static String getSObjectPluralLabel(String apiName) {
        return getSObjectDescribe(apiName).getLabelPlural();
    }

    // Returns the label of the field based on the current user language.
    public static String getFieldLabel(String SObjectApiName, String apiName) {
        return getFieldDescribe(SObjectApiName, apiName).getLabel();
    }

    // Returns the label of the field type.
    public static String getFieldType(String SObjectApiName, String apiName) {
        String fieldType;
        String key = SObjectApiName + apiName;
        if(!fieldTypes.containsKey(key)) {
            Schema.DisplayType displayType = getFieldDescribe(SObjectApiName, apiName).getType();
            System.debug('XXXXdisplayType: ' + DisplayType);
            switch on displayType {
                when DATE, DATETIME {
                    fieldType = 'date';
                }
                when EMAIL {
                    fieldType = 'email';
                }
                when INTEGER, DOUBLE {
                    fieldType = 'number';
                }
                when PHONE {
                    fieldType = 'phone';
                }
                when STRING, TEXTAREA {
                    fieldType = 'text';
                }
                when URL {
                    fieldType = 'url';
                }
                when ID {
                    fieldType = 'id';
                }
                when REFERENCE {
                    fieldType = 'reference';
                }
            }
            System.debug('SObjectApiName: ' + SObjectApiName + ', apiName: ' + apiName + ', fieldType: ' + fieldType);
            fieldTypes.put(key, fieldType);
        }
        else {
            fieldType = fieldTypes.get(key);
        }
        return fieldType;
    }

    // Returns the reference field actual name through the relationship.
    public static String getFieldReferenceName(String SObjectApiName, String apiName) {
        //System.debug('relationshipname: ' + getFieldDescribe(SObjectApiName, apiName).getRelationshipName());
        return getFieldDescribe(SObjectApiName, apiName).getRelationshipName() + '.Name';
    }

    // Returns the field type attributes for two particular cases: url fields and reference fields.
    public static Map<String, Object> getFieldTypeAttributes(String fieldType, String urlLabel) {
        System.debug('fieldType: ' + fieldType);
        System.debug('urlLabel: ' + urlLabel);

        Map<String, Object> typeAttributes = new Map<String, Object>();
        Map<String, String> urlAttributes = new Map<String, String>();
        switch on fieldType {
            // If the field type is an url, we will display "Go to URL" as a label.
            when 'url' {
                typeAttributes.put('label', 'Go to URL');
            }
            // If the field type is a reference, we will display the actual record name instead of the id as a label.
            when 'reference', 'dynamiclink' {
                if(urlLabel != null) {
                    urlAttributes.put('fieldName', urlLabel);
                }
                typeAttributes.put('label', urlAttributes);
            }
            // If the field type is a datetime, we will display also the hour and minutes in the proper format.
            when 'date' {
                typeAttributes.put('year', 'numeric');
                typeAttributes.put('month', 'numeric');
                typeAttributes.put('day', 'numeric');
                typeAttributes.put('hour', '2-digit');
                typeAttributes.put('minute', '2-digit');
                typeAttributes.put('time-zone-name', 'short');
                typeAttributes.put('hour12', 'true');
            }
        }
        return typeAttributes;
    }

    public class ColumnWrapper {
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String fieldName;
        @AuraEnabled
        public String type;
        @AuraEnabled
        public Map<String, Object> typeAttributes;
        @AuraEnabled
        public String orderLetter;

        public ColumnWrapper(String label, String fieldName, String type) {
            this.label = label;
            this.fieldName = fieldName;
            this.type = type;
        }
    }
}