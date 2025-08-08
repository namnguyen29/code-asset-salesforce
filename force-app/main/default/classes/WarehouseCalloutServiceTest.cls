@IsTest
public with sharing class WarehouseCalloutServiceTest {
  @Istest
  static void testCalloutSerivceSuccess() {
    Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
    Test.startTest();
    WarehouseCalloutService queable = new WarehouseCalloutService();
    System.enqueueJob(queable);
    Test.stopTest();

    Product2[] products = [
      SELECT
        Name,
        Replacement_Part__c,
        Cost__c,
        Current_Inventory__c,
        Lifespan_Months__c,
        Maintenance_Cycle__c,
        Warehouse_SKU__C
      FROM Product2
    ];

    System.assertEquals(
      true,
      products.get(0).Replacement_Part__c,
      'All products should have Replacement_Part__c set to true'
    );
  }
}