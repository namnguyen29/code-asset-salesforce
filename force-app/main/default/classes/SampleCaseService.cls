public with sharing class SampleCaseService {
    public static void createCase(Id contactId) {
        Case newCase = new Case(
            ContactId = contactId,
            Subject = 'Sample Issue from Apex',
            Description = 'This is a test case created via Apex code.',
            Status = 'New',
            Priority = 'Medium',
            Origin = 'Web'
        );

        try {
            insert newCase;
            System.debug('Successfully created Case ID: ' + newCase.Id);
        } catch (Exception err) {
            System.debug('Error creating case: ' + err.getMessage());
        }
    }
}