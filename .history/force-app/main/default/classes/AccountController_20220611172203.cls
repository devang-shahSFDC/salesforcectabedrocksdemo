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
		return [SELECT Name, Type FROM Account WHERE ParentId = NULL AND ID = '0018d00000AbkNdAAJ' LIMIT 20];
	}


}
