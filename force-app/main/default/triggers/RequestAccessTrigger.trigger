trigger RequestAccessTrigger on Request_Access__c (before insert) 
{
    Boolean isFirsttime = true;
    List<Request_Access__c> Requestlist = New list<Request_Access__c>();
    Requestlist = [select  id  From Request_Access__c where Request_Status__c != 'Rejected' and createdbyid = :userinfo.getUserId()];
    for(Request_Access__c R : Trigger.New)
    {
        if(!Requestlist.isempty() && R.Request_Status__c != 'Rejected')
        {
            R.adderror('Can Not Create One More Record');
        }
    }
}