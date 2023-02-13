public with sharing class AccountController {
    public AccountController() {

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
    public id findTopLevelParent(Id acctId) {
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
