/*******************************************************************************************
 * @Name         AccountController 
 * @Author       Devang Shah <devang.shah@salesforce.com>
 * @Date         18/06/2022
 * @Group        Demo
 * @Description  Class to fetch account and account releated data
 *******************************************************************************************/
/* MODIFICATION LOG
 * Version   Developer           Date            Description
 *-------------------------------------------------------------------------------------------
 *  1.0      Devang Shah      18/06/2022         Initial Creation                                                   
 *******************************************************************************************/

public with sharing class AccountController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getCompanyHeadquartersAccount(String recordId){

        string accountName = GlobalUtils.getCompanyHeadquartersName();

        List<Account> accounts =  [SELECT Id, Name, Description, BillingStreet, 
        BillingCountry, BillingCity, BillingState,
        BillingPostalCode FROM Account WHERE Name = :accountName OR Id = :recordId LIMIT 1];
        
        //Strip inaccessible fields
        SObjectAccessDecision decision = Security.stripInaccessible(AccessType.READABLE,accounts, true);
        return (List<Account>) decision.getRecords();
    }
    


	@AuraEnabled(cacheable=true)
	public static List<Account> getAllParentAccounts() {
		return [SELECT Name, Type FROM Account WHERE ParentId = NULL LIMIT 20];
	}

	@AuraEnabled
	public static List<Account> getChildAccounts(Id parentId) {
		return [
			SELECT Name, Type, Parent.Name
			FROM Account
			WHERE ParentId = :parentId
		];
	}

    @AuraEnabled(cacheable=true)
	public static List<Account> getAllParentAccountsForAccount() {
        Id acctId = findTopLevelParent('0018d00000AbkNdAAJ');
		return [SELECT Name, Type FROM Account WHERE ParentId = NULL AND ID = :acctId LIMIT 20];
	}

    //find highest parent account from a child
    public static id findTopLevelParent(Id acctId) {
        Boolean isTopLevelAccount = false;
        account acct = new account();
        id currAcctId = acctId;

        while (!isTopLevelAccount) {

            acct = [select Id, ParentId From Account where Id = :currAcctId limit 1];
            if (acct.ParentID != null) {
                currAcctId = acct.ParentID;
            } else {
                isTopLevelAccount = true;
            }
        }

        return currAcctId;   
    }


}
