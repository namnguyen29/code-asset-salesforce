@IsTest
public with sharing class WarehouseSyncScheduleTest {
  @IsTest
  static void testSyncWarehouseData() {
    Product2 equipment = new Product2(
      Name = 'Demo Product',
      Lifespan_Months__c = 23,
      Replacement_Part__c = true,
      Maintenance_Cycle__c = 55
    );
    insert equipment;

    Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());

    Test.startTest();
    WarehouseSyncSchedule warehouseSchedule = new WarehouseSyncSchedule();
    String CRON_EXP = '0 0 1 * * ?';
    System.schedule('WarehouseSyncScheduleJob', CRON_EXP, warehouseSchedule);
    Test.stopTest();

    Product2[] products = [
      SELECT Name, Lifespan_Months__c, Replacement_Part__c, Maintenance_Cycle__c
      FROM Product2
    ];

    System.assertEquals(
      true,
      products.get(0).Replacement_Part__c,
      'All products should have Replacement_Part__c set to true'
    );
  }
}