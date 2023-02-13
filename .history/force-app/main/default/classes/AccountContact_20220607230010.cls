public with sharing class AccountContact {
    @AuraEnabled(cacheable=true)
    public static List<ContactAccounts> allContactsWithAccounts(){

        // Get All Contacts
        // return [SELECT Id, AccountId, Account.Name, Account.Phone, Account.Website, Contact.Name, Contact.Phone FROM AccountContactRelation WHERE ContactId IN (SELECT Id FROM Contact WHERE AccountId = '0018d000008jlQlAAI') ORDER BY Contact.Id];

        AccountContactRelation[] accConList = [SELECT Id, AccountId, Account.Name, Account.Phone, Account.Website, 
        ContactId, Contact.Name, Contact.Phone FROM  AccountContactRelation 
            WHERE ContactId IN (SELECT Id FROM Contact WHERE AccountId = '0018d000008jlQlAAI') ORDER BY Contact.Id];

        Set<Id> contactIds = new Set<Id>();
        List<ContactAccounts> caLst = new  List<ContactAccounts>();
        if(accConList != null && accConList.size() > 0 ){
            ContactAccounts ca;
            List<Account> aLst;
            for(AccountContactRelation acr : accConList){
                
                if(!contactIds.contains(acr.ContactId) ){
                    contactIds.add(acr.ContactId);
                    ca = new ContactAccounts(); 

                    Contact c = new Contact();
                    c.LastName = acr.Contact.Name;
                    c.Phone = acr.Contact.Phone;
                    c.Id = acr.Id;
                    ca.contact = c;

                    aLst = new List<Account>();

                    Account a = new Account();
                    a.Name = acr.Account.Name;
                    a.Phone = acr.Account.Phone;
                    a.Website = acr.Account.Website;
                    aLst.add(a);
                    ca.accounts = aLst;
    
                    caLst.add(ca);
    
                }  else  {
                    Account a = new Account();
                    a.Name = acr.Account.Name;
                    a.Phone = acr.Account.Phone;
                    a.Website = acr.Account.Website;
                    aLst.add(a);
                }

            }
        }
        return caLst;

    }

    @AuraEnabled(cacheable=true)
    public static List<Account> allAccountsWithContact(){
        return [SELECT Id, Name, Phone, Website, 
        (SELECT id, Name, Phone, Email FROM Contacts) FROM Account LIMIT 5];
    }

    public class ContactAccounts {
        @AuraEnabled
		public integer noOfRelatedAccounts;
        @AuraEnabled
		public Contact contact;
        @AuraEnabled
		public List<Account> accounts;
    }
}
