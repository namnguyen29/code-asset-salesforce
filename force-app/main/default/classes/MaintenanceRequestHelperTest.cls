@IsTest
public with sharing class MaintenanceRequestHelperTest {
  @TestSetup
  static void setupMockData() {
    Vehicle__c vehicle = new Vehicle__c(Name = 'Mock Car');
    insert vehicle;
    Case[] closedRequests = new List<Case>();
    for (Integer idx = 0; idx < 5; idx++) {
      closedRequests.add(
        new Case(
          Type = 'Routine Maintenance',
          Status = 'Working',
          Vehicle__c = vehicle.Id,
          Origin = 'Phone',
          Subject = 'TestCase' + idx
        )
      );
    }
    insert closedRequests;
    Product2 equipment = new Product2(
      Name = 'Demo Product',
      Lifespan_Months__c = 23,
      Replacement_Part__c = true,
      Maintenance_Cycle__c = 55
    );
    insert equipment;

    Equipment_Maintenance_Item__c[] equipmentMaintenanceItems = new List<Equipment_Maintenance_Item__c>();
    for (Case closedRequest : closedRequests) {
      equipmentMaintenanceItems.add(
        new Equipment_Maintenance_Item__c(Maintenance_Request__c = closedRequest.Id, Equipment__c = equipment.Id)
      );
    }
    insert equipmentMaintenanceItems;
  }

  @IsTest
  static void testUpdateWorkOrdersSuccess() {
    Case[] closedRequests = [
      SELECT Id, Type, Status, Vehicle__c, Origin, Subject, Date_Reported__c, Date_Due__c
      FROM Case
      WHERE Type = 'Routine Maintenance' AND Status = 'Working'
    ];
    for (Case closedRequest : closedRequests) {
      closedRequest.Status = 'Closed';
    }
    update closedRequests;

    Test.startTest();
    MaintenanceRequestHelper.updateWorkOrders(closedRequests);
    Test.stopTest();

    Case[] newRequests = [
      SELECT Id, Type, Status, Vehicle__c, Origin, Subject, Date_Reported__c, Date_Due__c
      FROM Case
      WHERE Type = 'Routine Maintenance' AND Status = 'New'
    ];
    System.assertEquals(10, newRequests.size(), 'There should be 5 new maintenance requests created.');
  }
}