trigger ContactTrigger on Contact(after insert, after update) {
    System.debug('on contact trigger');
    private static String TEST_HOME_PHONE = '9999';
    System.debug('view trigger opp type' + Trigger.operationType);

    if (Trigger.isAfter && Trigger.isUpdate) {
        Contact[] contacts = Trigger.new;
        if (contacts[0].HomePhone == TEST_HOME_PHONE) {
            SampleCaseService.createCase(contacts[0].Id);
        }
    }
}