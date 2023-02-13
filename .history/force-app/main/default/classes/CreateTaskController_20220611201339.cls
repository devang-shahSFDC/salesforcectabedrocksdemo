public with sharing class CreateTaskController {
    
    @AuraEnabled
    public static Task saveTask(String subject, String description, String priority, String type, String relatedTo ) {
        Task t = new Task();
        t.Subject = subject;
        t.Description = description;
        t.Priority = priority;
        t.Type = type;
        t.OwnerId = UserInfo.getUserId();
        t.WhatId =  Id.valueOf(relatedTo);       
        t.ActivityDate = Date.today() + 2;
        insert t;
        return t;
    }
}
