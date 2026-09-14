@IsTest
public with sharing class SampleCaseTest {
    @TestSetup
    static void makeData() {
        Contact testContact = new Contact();
        testContact.FirstName = 'Mr Nam';
        testContact.LastName = 'NguyenTest';
        insert testContact;
    }

    @IsTest
    static void createTestCase() {
        Contact[] contacts = [SELECT Id, FirstName FROM Contact WHERE FirstName = 'Mr Nam'];
        Test.startTest();
        if (contacts.size() > 0) {
            contacts[0].HomePhone = '9999';
            update contacts;
            SampleCaseService.createCase(contacts[0].Id);
        }
        Test.stopTest();

        Case[] cases = [SELECT Id, Subject FROM Case WHERE Subject = 'Sample Issue from Apex'];
        System.assertEquals(1, cases.size(), 'We have 1 case');
    }
}