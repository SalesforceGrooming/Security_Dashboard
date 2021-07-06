public class ApplicationApex 
{

    public String ApplicationCSV { get; set; }
    public string nameFile{get;set;}
    public Blob contentFile{get;set;}
    String[] filelines = new String[]{};
    List<Application__c> appstoupload;
    
    public Pagereference ReadFile()
    {
        try{
                
                nameFile =blobToString( contentFile,'ISO-8859-1');
                
                
                filelines = nameFile.split('\n');
            
                appstoupload = new List<Application__c>();
                for (Integer i=1;i<filelines.size();i++)
                {
                    String[] inputvalues = new String[]{};
                    inputvalues = filelines[i].split(',');
                    
                    Application__c app = new Application__c();
                    app.Name = inputvalues[0];
                    app.Business_Criticality_Availability__c = inputvalues[1];   
        
                    appstoupload.add(app);
                }
         }
         catch(Exception e){
                 ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured reading the CSV file'+e.getMessage());
                ApexPages.addMessage(errormsg);
         }       

        try{
            insert appstoupload;
        }
        catch (Exception e)
        {
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured inserting the records'+e.getMessage());
            ApexPages.addMessage(errormsg);
        }    
        return null;
    }
   
   
    public List<Application__c> getuploadedApp()
    {
        if (appstoupload!= NULL)
            if (appstoupload.size() > 0)
                return appstoupload;
            else
                return null;                    
        else
            return null;
    }  
    public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }         
}