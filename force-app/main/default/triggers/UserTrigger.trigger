trigger UserTrigger on Request_Access__c (before insert,after insert) 
{
  List<Request_Access__c> userrecord = new list<Request_Access__c>();
  userrecord = [select name,id,Request_Status__c,Requesting_Role__c from Request_Access__c];
  for(Request_Access__c R : Trigger.new)
  {
     if(R.Id == userinfo.getUserId())
     {
        Request_Access__c Req = New Request_Access__c();
         req.adderror('can not create one mor record');
     }
  }
}