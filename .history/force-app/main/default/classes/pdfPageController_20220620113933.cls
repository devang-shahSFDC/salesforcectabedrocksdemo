public with sharing class pdfPageController {
    public String pdfText{get;set;}
    public String pdfMap{get;set;}
    public pdfPageController() {
        pdfText = String.escapeSingleQuotes(
            ApexPages.currentPage().getParameters().get('pdfText')
        );
        pdfMap = String.escapeSingleQuotes(
            ApexPages.currentPage().getParameters().get('pdfMap')
        );
    }
}
