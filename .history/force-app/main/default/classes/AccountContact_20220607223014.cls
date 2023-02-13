public with sharing class AccountContact {
    @AuraEnabled(cacheable=true)
    public static List<AccountContactRelation> allContactsWithAccounts(){

        // Get All Contacts
        // return [SELECT Id, AccountId, Account.Name, Account.Phone, Account.Website, Contact.Name, Contact.Phone FROM AccountContactRelation WHERE ContactId IN (SELECT Id FROM Contact WHERE AccountId = '0018d000008jlQlAAI') ORDER BY Contact.Id];

        AccountContactRelation[] accConList = [SELECT Id, AccountId, Account.Name, Account.Phone, Account.Website, 
            Contact.Name, Contact.Phone FROM  AccountContactRelation 
            WHERE ContactId IN (SELECT Id FROM Contact WHERE AccountId = '0018d000008jlQlAAI') ORDER BY Contact.Id];

        Set<Id> contactIds = new Set<Id>();

        if(accConList != null && accConList.size() > 0 ){

        }

    }

    @AuraEnabled(cacheable=true)
    public static List<Account> allAccountsWithContact(){
        return [SELECT Id, Name, Phone, Website, 
        (SELECT id, Name, Phone, Email FROM Contacts) FROM Account LIMIT 5];
    }

    public class ContactAccounts {
        @AuraEnabled
		public number noOfRelatedAccounts;
        @AuraEnabled
		public Contact contact;
        @AuraEnabled
		public List<Account> accounts;
    }
}
