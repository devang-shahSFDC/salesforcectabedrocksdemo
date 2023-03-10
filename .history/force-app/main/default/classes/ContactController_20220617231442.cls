public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(String recordId) {
        return [
            SELECT  Id,
            Name,
            FirstName,
            LastName,
            Title,
            Phone,
            Email
            FROM Contact
            WHERE AccountId = :recordId
            WITH SECURITY_ENFORCED
            LIMIT 10
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> findContacts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [
            SELECT Id, Name, Title, Phone, Email
            FROM Contact
            WHERE Name LIKE :key 
            WITH SECURITY_ENFORCED
            LIMIT 10
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Contact getSingleContact() {
        return [
            SELECT Id, Name, Title, Phone, Email
            FROM Contact
            WITH SECURITY_ENFORCED
            LIMIT 1
        ];
    }
}