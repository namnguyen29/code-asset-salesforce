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

Contact[] contacts = [
  SELECT Id, Name, HomePhone
  FROM Contact
  WHERE HomePhone = '9999'
  WITH USER_MODE
];

System.debug(contacts);