public with sharing class MaintenanceRequestHelper {
  public static void updateWorkOrders(Case[] requests) {
    Case[] closedRequests = new List<Case>();
    Case[] newRequests = new List<Case>();
    Id[] equipmentIds = new List<Id>();
    Id[] closedRequestIds = new List<Id>();

    for (Case request : requests) {
      if ((request.Type == 'Routine Maintenance' || request.Type == 'Repair') && request.Status == 'Closed') {
        closedRequestIds.add(request.Id);
        closedRequests.add(request);
      }
    }

    for (Equipment_Maintenance_Item__c item : [
      SELECT Id, Maintenance_Request__c, Equipment__c
      FROM Equipment_Maintenance_Item__c
      WHERE Maintenance_Request__c IN :closedRequestIds
    ]) {
      equipmentIds.add(item.Equipment__c);
    }

    if (closedRequests.size() > 0) {
      Product2[] equipments = getEquipments(equipmentIds);
      Integer minCycle = (Integer) equipments.get(0).Maintenance_Cycle__c;
      Date newRequestClosedDate = Date.today().addDays(minCycle);

      for (Case closedRequest : closedRequests) {
        Case newRequest = new Case();
        newRequest.Status = 'New';
        newRequest.Type = 'Routine Maintenance';
        newRequest.Vehicle__c = closedRequest.Vehicle__c;
        newRequest.Origin = closedRequest.Origin;
        newRequest.Subject = 'New Maintenance Request';
        newRequest.Date_Reported__c = Date.today();
        newRequest.Date_Due__c = newRequestClosedDate;
        newRequests.add(newRequest);
      }
      insert newRequests;

      Equipment_Maintenance_Item__c[] equipmentMaintenanceItems = new List<Equipment_Maintenance_Item__c>();
      for (Id equipmentId : equipmentIds) {
        Equipment_Maintenance_Item__c emItem = new Equipment_Maintenance_Item__c();
        emItem.Equipment__c = equipmentId;
        equipmentMaintenanceItems.add(emItem);
      }

      for (Case newRequest : newRequests) {
        for (Equipment_Maintenance_Item__c emItem : equipmentMaintenanceItems) {
          emItem.Maintenance_Request__c = newRequest.Id;
        }
      }

      insert equipmentMaintenanceItems;
    }
  }

  private static Product2[] getEquipments(Id[] equipmentIds) {
    return [
      SELECT Maintenance_Cycle__c, Id
      FROM Product2
      WHERE Id IN :equipmentIds
      ORDER BY Maintenance_Cycle__c ASC
    ];
  }
}