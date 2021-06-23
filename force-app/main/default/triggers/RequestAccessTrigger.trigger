trigger RequestAccessTrigger on Request_Access__c (before insert) 
{
    Boolean isFirsttime = true;
    List<Request_Access__c> Requestlist = New list<Request_Access__c>();
    For(Request_Access__c req : [select name, id, Request_Status__c, Requesting_Role__c,createdby.id From Request_Access__c])
    {
        for(Request_Access__c R : Trigger.New)
        {
          if(Req.createdby.id == userinfo.getUserId())
          {
              if(R.Request_Status__c == 'Pending' || R.Request_Status__c == 'Approved')
              {
                  R.adderror('Can Not Create One More Record');
              }
              if(R.Request_Status__c == 'Rejected')
              {
                  Requestlist.add(R);
              }
          }
        }
    }
}