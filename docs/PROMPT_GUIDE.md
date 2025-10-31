# Prompt Engineering Guide

Comprehensive guide to working effectively with Cursor IDE and AI agents.

## Table of Contents

- [Prompt Frameworks](#prompt-frameworks)
- [Slash Commands](#slash-commands)
- [Context Management](#context-management)
- [Best Practices](#best-practices)
- [Common Patterns](#common-patterns)

## Prompt Frameworks

### Feature Development Framework

Use this framework when implementing a new feature:

```markdown
/feature [feature-name]

## Context
- Related files: [list]
- Dependencies: [list]
- Constraints: [list]

## Requirements
1. [Requirement 1]
2. [Requirement 2]
3. [Requirement 3]

## Acceptance Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Technical Approach
[High-level approach]

## Tests Required
- Unit tests: [what to test]
- Integration tests: [what to test]
- E2E tests: [what to test]
```

**Example**:
```markdown
/feature user-authentication

## Context
- Related files: src/auth/, src/middleware/auth.ts
- Dependencies: jsonwebtoken, bcrypt
- Constraints: Must work with existing user model

## Requirements
1. JWT-based authentication
2. Password hashing with bcrypt
3. Token refresh mechanism
4. Logout functionality

## Acceptance Criteria
- [ ] Users can log in with email/password
- [ ] JWT tokens are generated on successful login
- [ ] Tokens expire after 1 hour
- [ ] Refresh tokens work for 7 days
- [ ] Passwords are securely hashed

## Technical Approach
- Use JWT for stateless auth
- Store refresh tokens in database
- Implement middleware for protected routes

## Tests Required
- Unit tests: Token generation, password hashing
- Integration tests: Login flow, token refresh
- E2E tests: Full authentication flow
```

### Bug Fix Framework

```markdown
/fix [bug-description]

## Symptoms
[What's going wrong?]

## Expected Behavior
[What should happen?]

## Actual Behavior
[What's actually happening?]

## Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Result]

## Error Messages
```
[Paste error messages/stack traces]
```

## Suspected Cause
[Your hypothesis]

## Proposed Fix
[How to fix it]

## Tests to Add
- [ ] Regression test for this bug
- [ ] Edge cases to prevent similar bugs
```

**Example**:
```markdown
/fix cart-total-calculation

## Symptoms
Cart total shows incorrect amount when applying discount

## Expected Behavior
Cart total = (sum of items) - discount

## Actual Behavior
Cart total = sum of items (discount not applied)

## Steps to Reproduce
1. Add items to cart (total: $100)
2. Apply 10% discount code
3. Total still shows $100 instead of $90

## Error Messages
No errors, just wrong calculation

## Suspected Cause
Discount not being passed to calculateTotal function

## Proposed Fix
Pass discount to calculateTotal and apply it correctly

## Tests to Add
- [ ] Test cart total with discount
- [ ] Test cart total without discount
- [ ] Test edge cases (discount > total, 0% discount, etc.)
```

### Refactoring Framework

```markdown
/refactor [area-to-refactor]

## Current State
[What exists now?]

## Problems
1. [Problem 1]
2. [Problem 2]

## Goals
1. [Goal 1]
2. [Goal 2]

## Approach
[How to refactor]

## Constraints
- [ ] Must maintain backward compatibility
- [ ] Must not change behavior
- [ ] Must improve [metric]

## Verification
- [ ] All existing tests pass
- [ ] No performance regression
- [ ] Code is simpler/clearer
```

**Example**:
```markdown
/refactor user-service

## Current State
UserService has 15 methods, 500+ lines, handles auth, profile, and settings

## Problems
1. Single Responsibility Principle violated
2. Hard to test (too many dependencies)
3. Difficult to navigate

## Goals
1. Split into AuthService, ProfileService, SettingsService
2. Each service <200 lines
3. Clear separation of concerns

## Approach
1. Extract auth methods to AuthService
2. Extract profile methods to ProfileService
3. Extract settings methods to SettingsService
4. Update imports and DI

## Constraints
- [x] Must maintain backward compatibility
- [x] Must not change behavior
- [x] Must improve testability

## Verification
- [ ] All existing tests pass without changes
- [ ] No performance regression
- [ ] Each service is focused and clear
```

### Testing Framework

```markdown
/test [component-to-test]

## What to Test
[Component/function/module name]

## Test Categories
- [ ] Unit tests
- [ ] Integration tests
- [ ] E2E tests

## Test Cases

### Happy Path
1. [Case 1]
2. [Case 2]

### Error Cases
1. [Error case 1]
2. [Error case 2]

### Edge Cases
1. [Edge case 1]
2. [Edge case 2]

## Coverage Target
[X]% (minimum 80%)

## Mocks Needed
- [Mock 1]
- [Mock 2]
```

**Example**:
```markdown
/test calculateDiscount

## What to Test
src/utils/pricing.ts:calculateDiscount

## Test Categories
- [x] Unit tests
- [ ] Integration tests (not needed)
- [ ] E2E tests (covered by checkout flow)

## Test Cases

### Happy Path
1. Valid percentage discount (10% of $100 = $10)
2. Valid fixed discount ($10 off $100 = $90)
3. Multiple discounts applied correctly

### Error Cases
1. Negative discount amount
2. Discount > total price
3. Invalid discount type

### Edge Cases
1. 0% discount
2. 100% discount
3. Discount = exact total
4. Very small amounts (rounding)

## Coverage Target
100% (utility function)

## Mocks Needed
None (pure function)
```

### Documentation Framework

```markdown
/docs [what-to-document]

## Audience
[Who will read this?]

## Purpose
[Why does this documentation exist?]

## Sections Needed
- [ ] Overview
- [ ] Getting Started
- [ ] Examples
- [ ] API Reference
- [ ] Troubleshooting

## Examples to Include
1. [Example 1]
2. [Example 2]

## Links Needed
- [Related doc 1]
- [Related doc 2]
```

### Performance Optimization Framework

```markdown
/optimize [area-to-optimize]

## Current Performance
[Metrics: response time, throughput, memory, etc.]

## Performance Goal
[Target metrics]

## Bottlenecks Identified
1. [Bottleneck 1]
2. [Bottleneck 2]

## Proposed Optimizations
1. [Optimization 1]
2. [Optimization 2]

## Benchmarks
[How will you measure improvement?]

## Trade-offs
[What are you sacrificing? Complexity? Memory? etc.]

## Verification
- [ ] Benchmarks run and compared
- [ ] Performance improved by [X]%
- [ ] No functionality regressions
```

## Slash Commands

### Core Commands

#### `/feature`
Start a new feature with structured requirements

```
/feature user-notifications
```

#### `/fix`
Fix a bug with clear reproduction steps

```
/fix memory-leak-websocket
```

#### `/refactor`
Refactor code while maintaining behavior

```
/refactor payment-service
```

#### `/test`
Add or improve tests

```
/test user-authentication
```

#### `/docs`
Create or update documentation

```
/docs api-authentication
```

#### `/optimize`
Improve performance

```
/optimize database-queries
```

#### `/review`
Review code against quality rubric

```
/review
```

### Specialized Commands

#### `/spec`
Create a technical specification

```
/spec real-time-chat

This will create a SPEC document following the template.
```

#### `/adr`
Create an Architecture Decision Record

```
/adr use-graphql-vs-rest

Documents a significant technical decision.
```

#### `/migrate`
Plan and execute a migration

```
/migrate from-redux-to-zustand

Includes:
- Migration plan
- Backward compatibility
- Testing strategy
- Rollback plan
```

#### `/security`
Security review or fix

```
/security sql-injection-risk

Focuses on:
- Vulnerability identification
- Risk assessment
- Remediation
- Prevention
```

#### `/deploy`
Deployment planning

```
/deploy feature-flags

Includes:
- Rollout plan
- Monitoring
- Rollback strategy
```

### Meta Commands

#### `/rules`
Show or update Cursor rules

```
/rules show
/rules add [new rule]
/rules remove [rule to remove]
```

#### `/context`
Manage context and memory

```
/context add [information]
/context show
/context clear [topic]
```

#### `/explain`
Explain existing code

```
/explain src/complex-algorithm.ts

Provides:
- Purpose
- How it works
- Edge cases
- Potential issues
```

## Context Management

### Providing Effective Context

#### 1. File Context

```markdown
Files to consider:
- src/auth/login.ts (main implementation)
- src/auth/middleware.ts (auth middleware)
- tests/auth/login.test.ts (existing tests)
```

#### 2. Architectural Context

```markdown
Architecture:
- Monorepo with npm workspaces
- Microservices communicate via RabbitMQ
- PostgreSQL for data, Redis for cache
- React frontend, Node backend
```

#### 3. Constraint Context

```markdown
Constraints:
- Must support IE11 (legacy requirement)
- Response time <200ms
- Works offline (mobile app)
- PCI DSS compliant
```

#### 4. Historical Context

```markdown
Previous decisions:
- ADR-003: Chose JWT over sessions for scalability
- Last refactor: 2023-Q4, split UserService
- Known issue: #456, memory leak under high load
```

### Context Routing

Use an index file to route to detailed context:

```markdown
# Context Index

## For authentication work
→ See docs/architecture/auth.md
→ See ADR-003: JWT implementation

## For payment work
→ See docs/architecture/payments.md
→ See ADR-007: Stripe integration

## For database work
→ See docs/architecture/database.md
→ See migrations/ folder
```

### Context Prioritization

**High Priority** (always include):
- Files being modified
- Related tests
- Relevant constraints
- Current architecture

**Medium Priority** (include if relevant):
- Historical decisions (ADRs)
- Related features
- Performance requirements
- Security considerations

**Low Priority** (include if asked):
- Coding style preferences
- Team conventions
- Future plans

## Best Practices

### Do's ✅

1. **Be Specific**
   ```markdown
   ❌ "Fix the bug"
   ✅ "Fix null pointer exception in calculateDiscount when discount code is invalid"
   ```

2. **Provide Examples**
   ```markdown
   ❌ "Add validation"
   ✅ "Add validation: email format, password min 8 chars, username alphanumeric"
   ```

3. **Include Acceptance Criteria**
   ```markdown
   ✅ Acceptance Criteria:
   - [ ] Email validation rejects invalid formats
   - [ ] Password validation requires 8+ characters
   - [ ] Error messages are user-friendly
   ```

4. **Reference Existing Patterns**
   ```markdown
   ✅ "Follow the same pattern as UserService for error handling"
   ```

5. **Specify Test Requirements**
   ```markdown
   ✅ "Add unit tests for validation, integration test for full flow"
   ```

### Don'ts ❌

1. **Don't Be Vague**
   ```markdown
   ❌ "Make it better"
   ❌ "Improve performance"
   ❌ "Fix the issue"
   ```

2. **Don't Assume Context**
   ```markdown
   ❌ "Update the function" (which function?)
   ✅ "Update calculateTotal in src/cart/pricing.ts"
   ```

3. **Don't Ignore Constraints**
   ```markdown
   ❌ Implement without considering existing architecture
   ✅ Must work with existing PostgreSQL schema, no breaking changes
   ```

4. **Don't Skip Tests**
   ```markdown
   ❌ Just implement the feature
   ✅ Implement with tests: unit, integration, and E2E
   ```

5. **Don't Forget Documentation**
   ```markdown
   ❌ Code only
   ✅ Code + JSDoc + README update + ADR if architectural
   ```

## Common Patterns

### Pattern: Progressive Enhancement

Start simple, then add complexity:

```markdown
Phase 1: Implement basic feature
- Core functionality
- Happy path only
- Basic tests

Phase 2: Add error handling
- Validation
- Error cases
- Error tests

Phase 3: Add edge cases
- Boundary conditions
- Performance
- Comprehensive tests
```

### Pattern: Example-Driven

Provide examples of desired behavior:

```markdown
Example input:
```typescript
const cart = {
  items: [{ price: 10, quantity: 2 }],
  discount: { type: 'percentage', value: 10 }
};
```

Expected output:
```typescript
{
  subtotal: 20,
  discount: 2,
  total: 18
}
```
```

### Pattern: Constraint-First

Lead with constraints:

```markdown
Constraints:
- Must be backward compatible
- No new dependencies
- Performance <100ms
- Works in Node 18+

Then implement feature...
```

### Pattern: Test-First

Specify tests before implementation:

```markdown
Tests to add:
1. Happy path: valid input returns correct result
2. Error case: invalid input throws TypeError
3. Edge case: empty array returns 0

Then implement to make tests pass...
```

## Effective Prompts Examples

### Example 1: Clear Feature Request

```markdown
/feature password-reset

## Context
- Files: src/auth/password.ts, src/email/templates/
- Stack: Node.js, Express, Nodemailer
- Database: PostgreSQL with users table

## Requirements
1. User requests password reset via email
2. System sends reset link valid for 1 hour
3. User clicks link and enters new password
4. Password is securely hashed and updated

## Acceptance Criteria
- [ ] Reset link sent to email within 30 seconds
- [ ] Link expires after 1 hour
- [ ] Link can only be used once
- [ ] New password meets requirements (8+ chars, etc.)
- [ ] User can log in with new password

## Technical Approach
- Generate random token, store with expiry in database
- Send email with link containing token
- Validate token on password reset page
- Hash new password with bcrypt
- Update database and invalidate token

## Tests Required
- Unit: Token generation, validation, expiry
- Integration: Full reset flow
- E2E: User journey from request to login
```

### Example 2: Complex Bug Fix

```markdown
/fix race-condition-cart-checkout

## Symptoms
Occasionally, users are charged but order not created

## Expected Behavior
Payment and order creation are atomic - both succeed or both fail

## Actual Behavior
Payment succeeds but order creation fails, leaving inconsistent state

## Steps to Reproduce
1. Add items to cart
2. Click checkout rapidly multiple times
3. Sometimes: charged but no order

## Error Messages
```
Error: Unique constraint violation on order_id
at Database.insert (orders.ts:45)
```

## Suspected Cause
Race condition: multiple checkout requests process simultaneously
- Request 1: charge succeeds, starts order creation
- Request 2: charge succeeds, starts order creation
- Request 2 fails: order_id already exists

## Proposed Fix
1. Add idempotency key to checkout
2. Use database transaction for charge + order creation
3. Add unique constraint on cart_id for orders

## Tests to Add
- [ ] Concurrent checkout requests handled correctly
- [ ] Idempotency key prevents duplicate charges
- [ ] Transaction rolls back on any failure
- [ ] User sees clear error if checkout fails
```

### Example 3: Strategic Refactoring

```markdown
/refactor extract-payment-service

## Current State
PaymentController: 800 lines
- Handles Stripe, PayPal, Apple Pay
- Includes validation, processing, webhooks
- Tightly coupled to database models

## Problems
1. Violates Single Responsibility Principle
2. Difficult to test (many dependencies)
3. Hard to add new payment methods
4. Business logic mixed with framework code

## Goals
1. Extract StripeService, PayPalService, ApplePayService
2. Create PaymentService interface
3. Move business logic to domain layer
4. <200 lines per service

## Approach
1. Define IPaymentProvider interface
2. Implement StripeProvider, PayPalProvider, ApplePayProvider
3. Create PaymentService that uses providers
4. Update controller to use PaymentService
5. Move validation to middleware
6. Extract webhook handling to separate module

## Constraints
- [x] Must maintain backward compatibility (existing API)
- [x] Must not change behavior (same outputs)
- [x] Must improve testability (inject dependencies)

## Verification
- [ ] All 143 existing tests pass without changes
- [ ] No performance regression (<5ms difference)
- [ ] Code coverage maintained or improved
- [ ] Each service <200 lines, single responsibility
- [ ] New payment method can be added in <100 lines

## Migration Plan
1. Create new services alongside existing code
2. Add feature flag: use_new_payment_service
3. Deploy with flag disabled
4. Enable flag for 10% of traffic
5. Monitor for issues
6. Gradually increase to 100%
7. Remove old code and flag
```

## Token Budget Management

### Prioritize Context

When tokens are limited:

**Include** (high value):
- Task description
- Relevant code files
- Acceptance criteria
- Constraints

**Exclude** (low value):
- Entire codebase
- Historical discussions
- Personal preferences
- Obvious conventions

### Use References

Instead of pasting full files:

```markdown
❌ Bad:
[Paste entire 500-line file]

✅ Good:
See src/auth/login.ts lines 45-67 for current implementation
```

### Chunk Large Tasks

```markdown
Phase 1: Core authentication (this prompt)
Phase 2: Password reset (next prompt)
Phase 3: OAuth integration (future prompt)
```

## Summary

Effective prompts:
- ✅ Are specific and clear
- ✅ Include context and constraints
- ✅ Provide examples
- ✅ Specify tests
- ✅ Define success criteria

Poor prompts:
- ❌ Are vague ("make it better")
- ❌ Lack context
- ❌ Skip test requirements
- ❌ Ignore constraints
- ❌ Don't define done

**Golden Rule**: Write prompts as if explaining to a smart colleague who doesn't know your project.
