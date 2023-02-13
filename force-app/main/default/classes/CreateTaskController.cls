/*******************************************************************************************
 * @Name         CreateTaskController 
 * @Author       Devang Shah <devang.shah@salesforce.com>
 * @Date         18/06/2022
 * @Group        Demo
 * @Description  Create Task
 *******************************************************************************************/
/* MODIFICATION LOG
 * Version   Developer           Date            Description
 *-------------------------------------------------------------------------------------------
 *  1.0      Devang Shah      18/06/2022         Initial Creation                                                   
 *******************************************************************************************/
public with sharing class CreateTaskController {
    
    @AuraEnabled
    public static Task saveTask(String subject, String description, String priority, String type, String relatedTo ) {

        if(Schema.SObjectType.Task.isCreateable()){        
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
        System.debug('User is not having create permission for Task');
        return null;
    }
}