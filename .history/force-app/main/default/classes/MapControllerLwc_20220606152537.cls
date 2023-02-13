public with sharing class MapControllerLwc {

   @AuraEnabled(cacheable=true)
   public static List<Account> getAccounts(){
       return [SELECT Id, Name, Description, BillingStreet, 
       BillingCountry, BillingCity, BillingState,
       BillingPostalCode FROM Account ORDER BY Name LIMIT 30];
   }


   @AuraEnabled(cacheable=true)
   public static List<Account> getCompanyBranches(String type1, String type2){
       return [SELECT Id, Name, Description, BillingStreet, 
       BillingCountry, BillingCity, BillingState,
       BillingPostalCode FROM Account WHERE Type = :type1 OR Type = :type2 LIMIT 30];
   }

}
