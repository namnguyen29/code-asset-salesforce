public with sharing class WarehouseCalloutService implements Queueable, Database.AllowsCallouts {
  public void execute(QueueableContext context) {
    Http http = new Http();
    HttpRequest httpRequest = new HttpRequest();
    httpRequest.setEndpoint('https://th-superbadge-apex.herokuapp.com/equipment');
    httpRequest.setMethod('GET');

    try {
      HttpResponse httpResponse = http.send(httpRequest);
      if (httpResponse.getStatusCode() == 200) {
        List<Object> responses = (List<Object>) JSON.deserializeUntyped(httpResponse.getBody());
        List<Map<String, Object>> responseMaps = new List<Map<String, Object>>();
        for (Object response : responses) {
          Map<String, Object> responseMap = (Map<String, Object>) response;
          responseMaps.add(responseMap);
        }

        EquipmentWrapper[] equipments = new List<EquipmentWrapper>();
        for (Map<String, Object> response : responseMaps) {
          EquipmentWrapper equipment = new EquipmentWrapper();
          equipment.id = (String) (response.containsKey('_id') ? response.get('_id') : '');
          equipment.replacement = true;
          equipment.cost = (Integer) (response.containsKey('cost') ? response.get('cost') : 0);
          equipment.lifespan = (Integer) (response.containsKey('lifespan') ? response.get('lifespan') : 0);
          equipment.maintenanceperiod = (Integer) (response.containsKey('maintenanceperiod')
            ? response.get('maintenanceperiod')
            : 0);
          equipment.name = (String) (response.containsKey('name') ? response.get('name') : '');
          equipment.quantity = (Integer) (response.containsKey('quantity') ? response.get('quantity') : 0);
          equipment.sku = (String) (response.containsKey('sku') ? response.get('sku') : '');
          equipments.add(equipment);
        }

        Product2[] products = new List<Product2>();

        System.debug(equipments.size());

        for (EquipmentWrapper equipment : equipments) {
          Product2 product = new Product2();
          product.Name = equipment.name;
          product.Replacement_Part__c = equipment.replacement;
          product.Cost__c = equipment.cost;
          product.Current_Inventory__c = equipment.quantity;
          product.Lifespan_Months__c = equipment.lifespan;
          product.Maintenance_Cycle__c = equipment.maintenanceperiod;
          product.Warehouse_SKU__C = equipment.sku;
          products.add(product);
        }

        upsert products;
      }
    } catch (Exception error) {
      System.debug(error.getMessage());
    }
  }

  @TestVisible
  private class EquipmentWrapper {
    public String id { get; set; }
    public Boolean replacement { get; set; }
    public Integer quantity { get; set; }
    public String name { get; set; }
    public Integer maintenanceperiod { get; set; }
    public Integer lifespan { get; set; }
    public Integer cost { get; set; }
    public String externalId { get; set; }
    public String sku { get; set; }
  }
}