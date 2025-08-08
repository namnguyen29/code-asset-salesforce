public with sharing class WarehouseSyncSchedule implements Schedulable {
  public void execute(SchedulableContext schedulableContext) {
    System.enqueueJob(new WarehouseCalloutService());
  }
}