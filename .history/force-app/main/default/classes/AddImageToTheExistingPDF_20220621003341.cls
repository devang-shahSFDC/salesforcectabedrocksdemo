public class AddImageToTheExistingPDF {
    
    @AuraEnabled  
    public static void addImageToPDF()
    {
        String API_KEY = 'dshah@acumensolutions.com_17e915c4308eec0459050e53ef407bb7e1de163db6a09cd79ffd6cac63b99690bb3598a9';        
        string SourceFileUrl = 'https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf';
        //string SourceFileUrl = 'https://democom60-dev-ed--c.documentforce.com/servlet/servlet.FileDownload?file=00P8d000000jTkqEAE&operationContext=S1';
       
        string Pages = '';
        string Password = '';
        String DestinationFile = 'result';

        string Type1  = 'image';
        Integer X = 30;
        Integer Y = 500;
        Integer Width1  = 459;
        Integer Height1  = 459;
        //String ImageUrl = 'https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png';
        String ImageUrl = 'https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=12&size=550x550&&maptype=roadmap&markers=color:red|label:S|40.7178,-74.015794&markers=color:red|label:G|40.711614,-74.012318&markers=color:red|label:C|40.718217,-73.998284&markers=color:red|label:C|37.811039,-122.477567&markers=color:red|label:C|40.6892,-74.0445&markers=color:red|label:C|40.718217,-73.998284&sensor=false&key=AIzaSyAUecX975bramgoVzuBuX6tNycTqKh70uk';

        Map<string, Object> parameters = new Map<string, Object>();
        parameters.put('name', DestinationFile);
        parameters.put('password', Password);
        parameters.put('pages', Pages);
        parameters.put('url', SourceFileUrl);
        parameters.put('type', Type1);
        parameters.put('x', X);
        parameters.put('y', Y);
        parameters.put('width', Width1);
        parameters.put('height', Height1);
        parameters.put('urlimage', ImageUrl);
        
        string jsonPayload = Json.serialize(parameters);
        try
        {
            string url = 'https://api.pdf.co/v1/pdf/edit/add';
            HttpRequest req = new HttpRequest();
            req.setBody(jsonPayload);
            req.setHeader('x-api-key', API_KEY);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint(url);
            req.setMethod('POST');
            req.setTimeout(120000);
            Http http = new Http();
            HTTPResponse res = http.send(req);
            if(res.getStatusCode() == 200) 
            {
                System.Debug('res ' + res);
                Map<String, Object> deserializedBody =  (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                String urlVal = (String)deserializedBody.get('url');
                downloadPDFAndStore(urlVal, DestinationFile);
            }
            else
            {
                System.debug('Success Response ' + res.getBody());
                System.Debug(' Status ' + res.getStatus());
                System.Debug(' Status Code' + res.getStatusCode());
                System.Debug(' Status String' + res.toString());
            }
           
        }
        catch(Exception ex)
        {
            String errorBody = 'Message: ' + ex.getMessage() + ' -- Cause: ' + ex.getCause() + ' -- Stacktrace: ' + ex.getStackTraceString();
            System.Debug(errorBody);
        }
    }

    @TestVisible
    private static void downloadPDFAndStore(String extFileUrl, String DestinationFile)
    {
        try
        {
            Http h = new Http(); 
            HttpRequest req = new HttpRequest(); 
            extFileUrl = extFileUrl.replace(' ', '%20'); 
            req.setEndpoint(extFileUrl); 
            req.setMethod('GET'); 
            req.setHeader('Content-Type', 'application/pdf'); 
            req.setCompressed(true); 
            req.setTimeout(60000); 
            //Now Send HTTP Request
            HttpResponse res  = h.send(req); 
            if(res.getStatusCode() == 200) 
            {
                blob fileContent = res.getBodyAsBlob();
                ContentVersion conVer = new ContentVersion();
                conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
                conVer.PathOnClient = DestinationFile + '.pdf'; // The files name, extension is very important here which will help the file in preview.
                conVer.Title = DestinationFile; // Display name of the files
                conVer.VersionData = fileContent;
                insert conVer;


                Account acc = new Account(Id='0018d000008eWmGAAU');
                Attachment objAttachment = new Attachment();
                objAttachment.Name='clientplan.pdf';
                objAttachment.ParentId = acc.Id;
                objAttachment.Body = fileContent;
                objAttachment.IsPrivate = false;
                insert objAttachment;
                System.Debug('Success');
            }
            else
            {
                System.debug('Success Response ' + res.getBody());
                System.Debug(' Status ' + res.getStatus());
                System.Debug(' Status Code' + res.getStatusCode());
                System.Debug(' Status String' + res.toString());
            }
        }
        catch(Exception ex)
        {
            String errorBody = 'Message: ' + ex.getMessage() + ' -- Cause: ' + ex.getCause() + ' -- Stacktrace: ' + ex.getStackTraceString();
            System.Debug(errorBody);
        }
    }
}