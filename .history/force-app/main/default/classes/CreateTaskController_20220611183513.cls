public with sharing class CreateTaskController {
    public static Task saveTask(String subject, String description, String priority, String type) {
        Task t = new Task();
        t.Subject = subject;
        t.Descriptition = description;
        t.Priority = priotiry;
        t.Type = type;
        t.OwnerId = UserInfo.getUserId();
        t.ActivityDate = Date.today() + 2;
        insert t;
        return t;
    }
}
