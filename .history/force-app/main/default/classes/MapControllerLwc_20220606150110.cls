public with sharing class MapControllerLwc {
    
   @AuraEnabled(cacheable=true)
   public static List<Account> getAccounts(){
       return [SELECT Id, Name, Description, BillingStreet, 
       BillingCountry, BillingCity, BillingState,
       BillingPostalCode FROM Account ORDER BY Name LIMIT 30];
   }

   @AuraEnabled(cacheable=true)
   public static List<Account> getCompanyHeadquarters(){
       return [SELECT Id, Name, Description, BillingStreet, 
       BillingCountry, BillingCity, BillingState,
       BillingPostalCode FROM Account WHERE Type = 'Company Headquarters' LIMIT 1];
   }


   @AuraEnabled(cacheable=true)
   public static List<Account> getCompanyBranches(){
       return [SELECT Id, Name, Description, BillingStreet, 
       BillingCountry, BillingCity, BillingState,
       BillingPostalCode FROM Account WHERE Type = 'Company Branches' ];
   }

}
