trigger ContactTrigger on Contact(after insert, after update) {
    System.debug('on contact trigger');

    if (Trigger.isAfter && Trigger.isUpdate) {
        Contact[] contacts = Trigger.new;
        if (contacts[0].HomePhone == '9999') {
            SampleCaseService.createCase(contacts[0].Id);
        }
    }
}