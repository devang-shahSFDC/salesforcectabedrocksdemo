public with sharing class AccountContact {
    @AuraEnabled(cacheable=true)
    public static List<Account> allContactsWithAccounts(){
        // return [SELECT Id, Name, Phone, Website, 
        // (SELECT id, Name, Phone, Email FROM Contacts) FROM Account LIMIT 5];



        return [SELECT Id, AccountId, Account.Name, Account.Phone, Account.Website, Contact.Name, Contact.Phone FROM AccountContactRelation WHERE ContactId IN (SELECT Id FROM Contact WHERE AccountId = '0018d000008jlQlAAI')];

    }
}
