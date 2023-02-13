/*******************************************************************************************
 * @Name         ContactController 
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
public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<ContactAccounts> getAllContactsWithAccounts(String accountId){

        //Fetch contacts and accounts information based on passed accountId
        AccountContactRelation[] accConList = [SELECT Id, AccountId, Account.Name, Account.Phone, Account.Website, 
        ContactId, Contact.Name, Contact.Phone FROM  AccountContactRelation 
            WHERE ContactId IN (SELECT Id FROM Contact WHERE AccountId = :accountId) ORDER BY Contact.Id];

        //Strip inaccessible fields
        SObjectAccessDecision decision = Security.stripInaccessible(AccessType.READABLE,accConList, true);
        accConList = (List<AccountContactRelation>) decision.getRecords();

        Set<Id> contactIds = new Set<Id>();
        List<ContactAccounts> caLst = new  List<ContactAccounts>();
        if(accConList != null && accConList.size() > 0 ){
            ContactAccounts ca;
            List<Account> aLst;
            for(AccountContactRelation acr : accConList){
                
                if(!contactIds.contains(acr.ContactId) ){
                    contactIds.add(acr.ContactId);
                    ca = new ContactAccounts(); 
                    ca.Name = acr.Contact.Name;
                    ca.Phone = acr.Contact.Phone;

                    aLst = new List<Account>();

                    Account a = new Account();
                    a.Name = acr.Account.Name;
                    a.Phone = acr.Account.Phone;
                    a.Website = acr.Account.Website;
                    aLst.add(a);

                    ca.accounts = aLst;
                    ca.noOfRelatedAccounts = aLst.size();    
                    caLst.add(ca);
    
                }  else  {
                    Account a = new Account();
                    a.Name = acr.Account.Name;
                    a.Phone = acr.Account.Phone;
                    a.Website = acr.Account.Website;                    
                    aLst.add(a);
                    ca.noOfRelatedAccounts = aLst.size();
                }

            }
        }
        return caLst;
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(String accountId) {
        return [
            SELECT Id, FirstName, LastName, Title, Phone, Email
            FROM Contact
            WHERE AccountId = :accountId
            WITH SECURITY_ENFORCED
            LIMIT 15
        ];
    }

    public class ContactAccounts {
        @AuraEnabled
		public integer noOfRelatedAccounts;
        @AuraEnabled
		public String Name;
        @AuraEnabled
		public String Phone;
        @AuraEnabled
		public String Id;         
        @AuraEnabled
		public List<Account> accounts;
    }
}