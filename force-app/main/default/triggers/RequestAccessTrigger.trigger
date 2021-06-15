trigger RequestAccessTrigger on Request_Access__c (after  insert,before insert) 
{
   List<Request_Access__c> Requestlist = New list<Request_Access__c>();
    List<user> usr = New list<user>();
    For(Request_Access__c req : [select name, id, Request_Status__c, Requesting_Role__c,createdby.id From Request_Access__c])
    {
        for(Request_Access__c R : Trigger.New)
        {
                
            if(R.Request_Status__c == 'Pending' || R.Request_Status__c == 'Approval')
            {           
                    R.adderror('One Request At a Time');  
                
            }
                else if(Req.createdby.id == userinfo.getuserid())
                {
                    req.adderror ('can not create one more than record');
                }
  
            else
            {
                Requestlist.add(Req);
            }
        }
    }  
}