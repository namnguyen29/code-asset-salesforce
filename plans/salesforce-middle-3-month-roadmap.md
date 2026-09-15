# 3-Month Roadmap to Prepare for a Middle Salesforce Developer Job

## Goal

Prepare for a **Middle Salesforce Developer** job switch over the next 3 months.

Current production experience:

- Experience Cloud
- Data Cloud
- Marketing Cloud Next
- Apex / LWC / Flow
- Salesforce CRM development

Current gaps to improve:

- Integration depth
- Service Cloud hands-on experience
- Core Salesforce interview readiness
- Security and sharing fundamentals
- Ability to explain technical decisions clearly

The goal is **not** to learn every Salesforce product.

The goal is to become a solid Middle Salesforce Developer with:

- strong Salesforce development fundamentals
- practical integration knowledge
- solid security and sharing knowledge
- enough Service Cloud hands-on experience to avoid a major interview gap
- strong stories from real Experience Cloud, Data Cloud, and Marketing Cloud Next work

---

# Overall Focus

| Area                                                         | Suggested Effort | Target                                   |
| ------------------------------------------------------------ | ---------------: | ---------------------------------------- |
| Apex + Salesforce Core                                       |              25% | Strong enough for technical interviews   |
| Integration                                                  |              25% | Reach practical Middle level             |
| Security / Sharing                                           |              15% | Strong, especially for Experience Cloud  |
| Service Cloud                                                |              20% | Hands-on knowledge, not production claim |
| Existing Experience: Experience Cloud + Data Cloud + MC Next |              10% | Turn real work into interview strengths  |
| Interview / CV Preparation                                   |               5% | Present experience clearly               |

---

# Month 1 — Salesforce Developer Core

The first month is about becoming technically solid before adding more products.

## Week 1 — Apex Core Refresh

### Topics

- Trigger fundamentals
- Trigger context variables
- Bulkification
- SOQL
- DML
- Salesforce Collections
  - List
  - Set
  - Map
- Governor Limits
- Transactions
- Exception handling

### Must Be Able to Explain

- Why should SOQL not be placed inside a loop?
- Why should DML not be placed inside a loop?
- What happens if a transaction fails halfway?
- How would you process 200 records safely?
- When should logic be moved out of the trigger?

### Practice

Build or refactor a small trigger using:

```text
Trigger
   ↓
Handler
   ↓
Service
```

Avoid over-engineering. The goal is clean separation of responsibility.

---

## Week 2 — Async Apex

### Topics

- Future
- Queueable
- Batch Apex
- Scheduled Apex
- Async transaction boundaries
- Callouts from asynchronous Apex

### Focus

Understand **when to use each option**, not only syntax.

### Key Comparison

| Tool      | Good For                          |
| --------- | --------------------------------- |
| Future    | Legacy/simple async work          |
| Queueable | Most general async business logic |
| Batch     | Processing very large datasets    |
| Scheduled | Running jobs at scheduled times   |

### Questions to Practice

- Queueable vs Future?
- Queueable vs Batch?
- When would Batch Apex be required?
- Why might an external API call be moved into Queueable Apex?
- What happens when one async transaction fails?

---

## Week 3 — Salesforce Security and Sharing

This is especially important because Experience Cloud is already part of the production background.

### Topics

- Organization-Wide Defaults
- Role Hierarchy
- Sharing Rules
- Manual Sharing
- Apex Managed Sharing
- Profiles
- Permission Sets
- Permission Set Groups
- CRUD
- Field-Level Security
- `with sharing`
- `without sharing`
- `inherited sharing`
- Experience Cloud Sharing Sets

### Debugging Pattern

When a user says:

> I have access to the object but I cannot see the record.

Check roughly:

```text
Object Permission
       ↓
Field-Level Security
       ↓
Record Ownership
       ↓
OWD
       ↓
Role Hierarchy
       ↓
Sharing Rule
       ↓
Manual / Apex Sharing
```

For Experience Cloud, also inspect:

```text
External User
      ↓
Contact
      ↓
Account
      ↓
Sharing Set / Sharing Rule
```

---

## Week 4 — Apex Testing

### Topics

- Test data creation
- `@testSetup`
- `Test.startTest()`
- `Test.stopTest()`
- Positive tests
- Negative tests
- Bulk tests
- Async Apex tests
- HTTP callout mock
- Assertions

### Goal

Do not optimize for code coverage only.

Tests should prove:

- correct output
- incorrect input handling
- bulk behavior
- permission or business-rule behavior
- integration responses

---

# Month 2 — Integration + Service Cloud

This is the most important month for filling current skill gaps.

---

## Week 5 — Salesforce → External System

Build a small integration:

```text
Contact Update
      ↓
Trigger / Flow
      ↓
Queueable Apex
      ↓
Named Credential
      ↓
External REST API
```

### Topics

- `Http`
- `HttpRequest`
- `HttpResponse`
- REST
- HTTP methods
- Headers
- Status codes
- JSON serialization
- JSON deserialization
- Named Credentials
- Authentication concepts
- Timeout handling
- Error handling

### Must Understand

Why this is usually better:

```text
Trigger
   ↓
Queueable
   ↓
Callout
```

instead of performing a remote callout directly inside normal trigger logic.

---

## Week 6 — External System → Salesforce

Create an Apex REST API.

Example:

```http
POST /services/apexrest/customers
```

Request:

```json
{
  "externalId": "ABC123",
  "firstName": "Minh",
  "lastName": "Nguyen"
}
```

Processing:

```text
Request
   ↓
Deserialize
   ↓
Validate
   ↓
Query / Upsert by External ID
   ↓
Save
   ↓
Return HTTP Response
```

### Topics

- Apex REST
- DTO / wrapper classes
- Input validation
- External ID
- Upsert
- Duplicate prevention
- Idempotency
- HTTP response codes
- Exception handling
- Transaction rollback

### Important Interview Scenario

If the external system sends the exact same request twice:

> How do you prevent duplicate Salesforce records?

A common approach:

```text
External ID
    +
Upsert
    +
Idempotent processing
```

---

## Week 7 — Service Cloud Foundation

Service Cloud is currently a gap, so build one small but complete hands-on project.

## Mini Project: Customer Support Portal

Reuse Experience Cloud knowledge.

Architecture:

```text
Experience Cloud User
          ↓
      Creates Case
          ↓
      Service Cloud
          ↓
    Assignment Rule
          ↓
        Queue
          ↓
        Agent
```

### Learn

- Case
- Account / Contact relationship
- Case Status
- Case Priority
- Case Origin
- Queue
- Assignment Rule
- Auto Response Rule
- Escalation Rule
- Service Console
- Email-to-Case

### Goal

Be able to explain the lifecycle:

```text
Customer
   ↓
Case Created
   ↓
Case Routed
   ↓
Agent Works
   ↓
Resolved
   ↓
Case Closed
```

---

## Week 8 — Service Cloud Routing

Extend the mini project.

### Topics

- Omni-Channel
- Presence Status
- Routing Configuration
- Queue-Based Routing
- Service Console
- Knowledge
- Entitlement concepts
- Milestones
- SLA concepts

### Example Final Flow

```text
Experience Cloud
       ↓
Customer Creates Case
       ↓
Assignment Rule
       ↓
Queue
       ↓
Omni-Channel
       ↓
Agent
       ↓
Knowledge Article
       ↓
Resolution
```

### Important

After this project, it is reasonable to say:

> I have hands-on experience with core Service Cloud case management and Omni-Channel scenarios in a sandbox.

Do **not** claim production Service Cloud experience if there has been none.

---

# Month 3 — Turn Real Experience into Interview Strength

Do not spend this month learning another Salesforce Cloud from scratch.

The focus should be:

- strengthen existing production knowledge
- practice explaining architecture
- prepare interview stories
- fix remaining weak areas

---

## Week 9 — Experience Cloud Deep Review

Experience Cloud should become one of the strongest interview areas.

### Review

```text
External User
      ↓
Contact
      ↓
Account
      ↓
Experience Site
```

### Topics

- External users
- Contact relationship
- Account relationship
- Experience Cloud licenses
- Profiles
- Permission Sets
- Sharing Sets
- Sharing Rules
- Guest User access
- Self-registration
- Login
- Apex in Experience Cloud
- LWC in Experience Cloud
- External user security
- Internal vs external record visibility

### Interview Goal

Be able to explain a real production problem such as:

> An Experience Cloud user has object permission but cannot update a Contact.

Walk through:

```text
CRUD / FLS
   ↓
Record Access
   ↓
Sharing Set
   ↓
Account / Contact Relationship
   ↓
Apex Sharing Context
```

---

# Week 10 — Data Cloud + Marketing Cloud Next Review

These are already production strengths.

Do not study them as beginner products again.

Instead, organize the knowledge into clear interview stories.

---

## Data Cloud

Be able to explain this pipeline:

```text
CRM
 ↓
Data Stream
 ↓
DLO
 ↓
DMO
 ↓
Identity Resolution
 ↓
Unified Individual
 ↓
Segment
 ↓
Activation
```

### Questions to Prepare

- What is a DLO?
- What is a DMO?
- Why is mapping required?
- What is an Individual?
- What is a Unified Individual?
- What does Identity Resolution do?
- Why might a segment population be zero?
- What is segment activation?
- Segment membership vs Campaign Member?
- What refresh or synchronization delays have you experienced?

---

## Marketing Cloud Next

Be able to explain:

```text
CRM Event
    ↓
Engagement Signal
    ↓
Flow / Orchestration
    ↓
Marketing Cloud Next
    ↓
Email
```

### Topics

- Transactional Email
- Promotional Email
- Opt-in
- Opt-out
- Engagement Signals
- Handlebars
- Email personalization
- Bounce concepts
- CRM → Marketing synchronization
- Winner / loser communication flow
- Event identifiers

### Goal

Turn production issues into interview stories:

```text
Problem
   ↓
Investigation
   ↓
Root Cause
   ↓
Solution
   ↓
Result
```

---

# Week 11 — Interview Preparation

Split preparation into five areas.

---

## 1. Apex

Practice questions such as:

- `Trigger.new` vs `Trigger.old`
- Why no SOQL inside loops?
- What are governor limits?
- Queueable vs Batch?
- What does `Database.Stateful` do?
- What happens if one DML statement fails?
- How do you design bulk-safe Apex?
- How do you test callouts?

---

## 2. Integration

Practice questions such as:

- What is a Named Credential?
- How should Salesforce call an external REST API?
- Why use Queueable for integration?
- What happens if the external system times out?
- How would you retry?
- What is an External ID?
- What does upsert do?
- How do you prevent duplicate API requests from creating duplicates?
- Sync vs async integration?
- Platform Event vs REST API?
- When would CDC be useful?

---

## 3. Security

Practice scenarios.

Example:

```text
User can read Contact object
but cannot see Contact X.
```

Explain how to investigate.

Another:

```text
Experience Cloud user
must only access records
belonging to their Account.
```

Explain how Salesforce sharing could support this.

---

## 4. Experience Cloud

This should be a high-confidence section.

Practice explaining:

- external user model
- Person Account / Contact implications where relevant
- external user registration
- access control
- sharing sets
- guest access
- custom Apex APIs
- LWC frontend integration
- common production issues

---

## 5. Service Cloud

Prepare for:

> Walk me through a basic customer support implementation.

Suggested answer structure:

```text
Customer
   ↓
Experience Cloud / Email
   ↓
Case
   ↓
Assignment Rule
   ↓
Queue
   ↓
Omni-Channel
   ↓
Agent
   ↓
Knowledge / Resolution
   ↓
Close Case
```

---

# Week 12 — Mock Interview + CV

Use the final week mainly for repetition and presentation.

## Mock Interview Sessions

Suggested split:

### Session 1

- Apex
- Async Apex
- Unit Tests

### Session 2

- Integration
- API design
- Failure scenarios

### Session 3

- Security
- Experience Cloud

### Session 4

- Service Cloud
- Data Cloud
- Marketing Cloud Next

### Session 5

Full mock interview.

---

# Suggested CV Positioning

Avoid a CV that looks like only a list of Salesforce technologies.

Instead of:

> Salesforce Developer — 2 Years  
> Apex, LWC, Flow, Data Cloud, Experience Cloud...

Use positioning closer to:

> Salesforce Developer with production experience across Experience Cloud, Data Cloud, and Marketing Cloud Next, building Apex/LWC solutions, external-user portals, CRM automation, and customer engagement workflows.

After completing the 3-month plan, Service Cloud can be described carefully as:

> Hands-on experience with Service Cloud case management and Omni-Channel through sandbox projects.

Do not label it production experience.

---

# Personal Skill Target After 3 Months

A rough target:

| Skill                |                           Target |
| -------------------- | -------------------------------: |
| Apex                 |                             8/10 |
| LWC                  |                             7/10 |
| Security / Sharing   |                           7–8/10 |
| Integration          |                             7/10 |
| Experience Cloud     |                             8/10 |
| Service Cloud        |                           5–6/10 |
| Data Cloud           | Keep current production strength |
| Marketing Cloud Next | Keep current production strength |

The exact score is not important.

The intention is:

```text
Strong Core Developer
       +
Strong Experience Cloud
       +
Practical Integration
       +
Solid Security
       +
Enough Service Cloud
       +
Real Data Cloud / MC Next Experience
```

---

# Integration Mini Projects

Try to complete at least two.

## Project A — Salesforce → External REST API

```text
Opportunity Closed Won
        ↓
Queueable Apex
        ↓
Named Credential
        ↓
External Order API
        ↓
Save Result / Log Error
```

Practice:

- serialization
- authentication
- async processing
- callouts
- error handling
- retry thinking

---

## Project B — External API → Salesforce

```text
External Customer API
        ↓
Apex REST
        ↓
Validate Request
        ↓
Upsert by External ID
        ↓
Create / Update Contact
```

Practice:

- Apex REST
- idempotency
- External ID
- validation
- HTTP response design

---

## Optional Project C — Event Driven Integration

```text
Salesforce Record Change
          ↓
Platform Event / CDC
          ↓
External Subscriber
```

Understand the concepts even if the external consumer is only mocked.

---

# Service Cloud Mini Project

Build a small customer support application:

```text
Experience Cloud Portal
         ↓
Customer Creates Case
         ↓
Assignment Rule
         ↓
Support Queue
         ↓
Omni-Channel
         ↓
Support Agent
         ↓
Knowledge
         ↓
Close Case
```

Optional additions:

- Email-to-Case
- Auto Response Rule
- Escalation
- Entitlement
- Milestone
- simple Apex integration

This project is enough to remove the feeling of having **zero Service Cloud hands-on experience**.

---

# What NOT to Prioritize During These 3 Months

Avoid spending major time on:

- Financial Services Cloud
- Revenue Cloud
- CPQ
- OmniStudio deep dive
- Commerce Cloud
- Field Service
- Agentforce deep dive
- additional certifications purely for badges

They can be useful later.

For this job switch, the highest-return investment is:

```text
Apex
+
Integration
+
Security
+
Experience Cloud
+
Service Cloud foundation
+
Interview preparation
```

---

# Final Strategy

Do not try to look like a Senior Salesforce Architect.

The target profile is:

> A reliable Middle Salesforce Developer who has real production exposure to modern Salesforce products, understands Experience Cloud well, writes solid Apex/LWC, can work with APIs and integrations, understands Salesforce security, and has enough Service Cloud hands-on knowledge to contribute to common enterprise projects.

The strongest differentiator is the combination of:

```text
Experience Cloud
      +
Data Cloud
      +
Marketing Cloud Next
      +
Apex / LWC
```

The three-month preparation should mainly fill the missing pieces:

```text
Integration
+
Security Depth
+
Service Cloud
+
Interview Discipline
```

That creates a much more balanced Middle Salesforce Developer profile for the next job search.
