/*******************************************************************************************
 * @Name         GlobalUtils 
 * @Author       Devang Shah <devang.shah@salesforce.com>
 * @Date         18/06/2022
 * @Group        Demo
 * @Description  Class to fetch data required for map
 *******************************************************************************************/
/* MODIFICATION LOG
 * Version   Developer           Date            Description
 *-------------------------------------------------------------------------------------------
 *  1.0      Devang Shah      18/06/2022         Initial Creation                                                   
 *******************************************************************************************/

public with sharing class MapControllerLwc {

   @AuraEnabled(cacheable=true)
   public static List<Account> getAccounts(String accountType){
       return [SELECT Id, Name, Description, BillingStreet, 
       BillingCountry, BillingCity, BillingState,
       BillingPostalCode FROM Account WHERE Type = :accountType LIMIT 30];
   }
}
