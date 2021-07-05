@isTest(SeeAllData=true)
private class ApplicationApex_TestMethod
{

     static testmethod void testfileupload(){
         StaticResource testdoc = [Select Id,Body from StaticResource where name ='ApplicationCSV'];
         ApplicationApex  testUpload = new ApplicationApex();
         testUpload.contentFile= testdoc.Body;
         testUpload.ReadFile();
     }
}