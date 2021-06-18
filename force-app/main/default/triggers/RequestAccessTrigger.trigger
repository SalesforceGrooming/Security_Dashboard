trigger RequestAccessTrigger on Request_Access__c (before insert) 
{
   List<Request_Access__c> Requestlist = New list<Request_Access__c>();
    List<user> usr = New list<user>();
    For(Request_Access__c req : [select name, id, Ownerid, Request_Status__c, Requesting_Role__c,createdby.id From Request_Access__c])
    {
        for(Request_Access__c R : Trigger.new)
        {
            system.debug(Req.CreatedById);
            system.debug(userinfo.getuserid());
            system.debug(Req.OwnerId);
            System.debug(Req);
            if(Req.createdby.id == userinfo.getuserid())
            {  
              if(R.Request_Status__c == 'Pending' || R.Request_Status__c == 'Approved')
               {           
                    R.adderror('One Request At a Time');  
               }
            }
            else
            {
                Requestlist.add(R);
            }
        }
    }  
}