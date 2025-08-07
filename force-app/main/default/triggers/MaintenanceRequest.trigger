trigger MaintenanceRequest on Case(after update) {
  if (Trigger.isAfter) {
    MaintenanceRequestHelper.updateWorkOrders(Trigger.new);
  }
}