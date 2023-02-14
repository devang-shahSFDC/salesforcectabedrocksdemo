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
    public static List<Account> getCompanyHeadquartersAccount(){

        // Get Company Headquarters Name, set within custom metadata.
        //string accountName = GlobalUtils.getCompanyHeadquartersName();
        string accountName = 'Bedrock Enterprises';

        List<Account> accounts =  [SELECT Id, Name, Description, BillingStreet, 
        BillingCountry, BillingCity, BillingState,
        BillingPostalCode FROM Account WHERE Name = :accountName LIMIT 1];
        
        //Strip inaccessible fields
        SObjectAccessDecision decision = Security.stripInaccessible(AccessType.READABLE,accounts, true);
        return (List<Account>) decision.getRecords();
    }
    
    
	@AuraEnabled(cacheable=true)
	public static String getAccountName(Id accountId) {
        List<Account> accounts = [
            SELECT Id, Name
            FROM Account
            WHERE Id =: accountId
            LIMIT 1
        ];
        if(!accounts.isEmpty()){
            Account account = accounts[0]; 
            return account.Name;
        }
        return '';
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
	public static List<Account> getTopLevelParent(Id accountId) {
        Id acctId = findTopLevelParent(accountId);
		return [SELECT Name, Type FROM Account WHERE ParentId = NULL AND ID = :acctId LIMIT 1];
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