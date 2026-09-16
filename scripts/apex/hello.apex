Subscription__c sub = new Subscription__c();
sub.Subscription_Active__c = true;
sub.Subscription_Date__c = Datetime.now();
sub.Subscription_Type__c = 'Premium';
sub.Subscription_Id__c = String.valueOf(UUID.randomUUID());
sub.Contact__c = '003gK000010lpWQQAY';
insert sub;

/**
 * AggregateResult
 */
/*AggregateResult[] contacts = [
  SELECT AccountId accountId, COUNT(Id) contactCount
  FROM Contact
  GROUP BY AccountId
];

for (AggregateResult result : contacts) {
  System.debug(result.get('accountId'));
  System.debug(result.get('contactCount'));
} */

// Contact[] contacts = [
//   SELECT Id, Name, HomePhone
//   FROM Contact
//   WHERE HomePhone = '9999'
//   WITH USER_MODE
// ];

// System.debug(contacts);