1. What is the benefit of AggregateResult?

- Aggregate SOQL allows us to summarize data directly in Salesforce using functions such as COUNT, SUM, AVG, MIN and MAX. We can combine it with GROUP BY to aggregate records by a field and HAVING to filter the aggregated results. This avoids querying all records into Apex and performing the calculation in memory.

2. Compare WITH SECURITY_ENFORCED/ WITH USER_MODE / WITH SYSTEM_MODE

- SECURITY_ENFORCED: is a legacy SOQL security clause that enforces object-level read access and field-level security on fields queried in the SELECT clause. If the user doesn't have access to an object or field, Salesforce throws a QueryException.

- USER_MODE: executes the query using the current user's security context. It enforces object permissions, field-level security, record-level sharing, and other applicable access restrictions.
  **Note**: USER_MODE can overrides class sharing mode

- SYSTEM_MODE: executes the database operation with elevated privileges and bypasses the current user's object-level and field-level permissions.

API ver <= 66: run with SYSTEM_MODE; otherwise run with USER_MODE

```bash
Có Account → Contact → Subscription__c.

Subscription__c có:

- Contact__c
- Status__c
- Subscription_Type__c

Requirement:

Query tất cả Account thỏa:

1. Account đang Active.
2. Có ít nhất một Contact.
3. Contact đó có Subscription__c:
   Status__c = 'Active'
   Subscription_Type__c = 'Magazine'

Chỉ lấy:
Account Id
Account Name

Không được query nhiều lần.
```
