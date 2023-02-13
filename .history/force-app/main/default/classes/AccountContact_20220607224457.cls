public with sharing class AccountContact {
    @AuraEnabled(cacheable=true)
    public static List<AccountContactRelation> allContactsWithAccounts(){

        // Get All Contacts
        // return [SELECT Id, AccountId, Account.Name, Account.Phone, Account.Website, Contact.Name, Contact.Phone FROM AccountContactRelation WHERE ContactId IN (SELECT Id FROM Contact WHERE AccountId = '0018d000008jlQlAAI') ORDER BY Contact.Id];

        AccountContactRelation[] accConList = [SELECT Id, AccountId, Account.Name, Account.Phone, Account.Website, 
        ContactId, Contact.Name, Contact.Phone FROM  AccountContactRelation 
            WHERE ContactId IN (SELECT Id FROM Contact WHERE AccountId = '0018d000008jlQlAAI') ORDER BY Contact.Id];

        Set<Id> contactIds = new Set<Id>();
        List<ContactAccounts> caLst = new  List<ContactAccounts>();
        if(accConList != null && accConList.size() > 0 ){
            ContactAccounts ca;
            for(AccountContactRelation acr : accConList){
                
                if(!contactIds.contains(acr.ContactId) ){
                    contactIds.add(acr.ContactId);
                    ca = new ContactAccounts(); 
                }
                Contact c = new Contact();
                c.Name = acr.Contact.Name;
                c.Phone = acr.Contact.Phone;
                c.Id = acr.Id;
                ca.contact = c;

            }
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
