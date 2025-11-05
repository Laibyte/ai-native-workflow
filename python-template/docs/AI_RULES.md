# AI Rules, Hooks, Memory, and Background Agents

Complete guide to configuring Cursor IDE for optimal AI-native development.

## 📋 Table of Contents

- [Rules System](#rules-system)
- [Hooks](#hooks)
- [Memory Management](#memory-management)
- [Background Agents](#background-agents)
- [Best Practices](#best-practices)

## Rules System

Rules define invariants and conventions that AI agents must follow. They're the "laws of the land" for your codebase.

### Types of Rules

#### 1. Project Rules (`.cursorrules`)

Repository-specific conventions that live in the root of your project.

**Location**: `<project-root>/.cursorrules`

**Example**:
```markdown
# Project Rules

## Testing
- ALWAYS run tests after generating or modifying code
- Use Vitest for unit tests (npm run test)
- Use Playwright for E2E tests (npm run test:e2e)
- Minimum 80% coverage for new code
- Tests must pass before committing

## Package Management
- Use npm ONLY (never yarn or pnpm)
- Always update package-lock.json
- Run `npm install` after package.json changes

## Code Style
- Use TypeScript strict mode
- Follow ESLint rules (npm run lint)
- Format with Prettier (npm run format)
- Run type checking with `npm run typecheck`

## Documentation
- Update README.md for user-facing changes
- Add JSDoc for public APIs
- Create/update ADRs for architectural decisions

## Commits
- Follow conventional commits format
- Reference Linear issue in commit body
- Squash commits before merging

## Security
- Never commit secrets or API keys
- Use environment variables for configuration
- Validate all user inputs
```

#### 2. User Rules

Personal preferences that apply across all your projects.

**Location**: Cursor Settings → Rules → User Rules

**Example**:
```markdown
# My Personal Rules

## Code Generation
- Prefer functional programming over OOP when appropriate
- Use descriptive variable names (no single letters except i, j, k in loops)
- Add TODO comments for incomplete implementations
- Prefer composition over inheritance

## Testing
- Write tests before implementation (TDD)
- Use descriptive test names
- Group related tests with describe blocks

## Communication
- Explain reasoning for architectural decisions
- Flag potential performance issues
- Suggest alternatives when appropriate
```

#### 3. Overall Rules

Organization-wide standards that apply to all projects.

**Location**: Organization Settings → Rules (if available) or in each project

**Example**:
```markdown
# Organization-Wide Rules

## Security
- All dependencies must pass security audit
- No credentials in code or environment files
- Use approved secret management services
- Enable two-factor authentication

## Code Review
- All PRs require at least one approval
- Run self-review before requesting human review
- Address all review comments
- Update tests and docs with code changes

## Compliance
- Include license headers in source files
- Generate and maintain SBOM
- Document third-party dependencies
- Follow GDPR/CCPA guidelines for user data

## Quality
- Maintain >80% test coverage
- Zero high-severity vulnerabilities
- Pass all linting and type checks
- Document breaking changes
```

### Rule Structure Best Practices

**1. Be Specific**
```markdown
❌ Bad: Write good tests
✅ Good: Write unit tests with >80% coverage using Vitest, including edge cases
```

**2. Be Actionable**
```markdown
❌ Bad: Consider performance
✅ Good: Profile performance-critical paths; optimize if >100ms response time
```

**3. Include Examples**
```markdown
## Error Handling

Always handle errors explicitly:

❌ Bad:
```typescript
const data = await fetchUser();
```

✅ Good:
```typescript
try {
  const data = await fetchUser();
  return { success: true, data };
} catch (error) {
  logger.error('Failed to fetch user', { error });
  return { success: false, error: error.message };
}
```
```

**4. Organize by Domain**
```markdown
# Project Rules

## 1. Testing
...

## 2. Code Style
...

## 3. Documentation
...

## 4. Security
...

## 5. Performance
...
```

**5. Version Control**
```bash
# Commit .cursorrules with your project
git add .cursorrules
git commit -m "docs: update project rules for new testing standards"
```

### Golden Rules

These rules should appear in almost every project:

```markdown
# Golden Rules - Copy to Your .cursorrules

## Always Run Tests
- Execute tests after EVERY code change
- Run `npm run test` (or `poetry run pytest`) before committing
- If tests fail, fix them before proceeding
- If no tests exist, create them

## Package Manager Discipline
- [FOR TS/JS] Use npm only - never yarn or pnpm
- [FOR PYTHON] Use poetry only - never pip or conda
- Always commit lockfiles (package-lock.json or poetry.lock)
- Update lockfiles when adding/removing dependencies

## Quality Gates
- Linting must pass (npm run lint OR poetry run ruff check)
- Formatting must pass (npm run format OR poetry run black .)
- Type checking must pass (npm run typecheck OR poetry run mypy .)
- All checks must pass before committing

## Documentation Sync
- Update README.md when user-facing changes occur
- Create ADR for architectural decisions
- Add/update JSDoc or docstrings for public APIs
- Update CHANGELOG.md

## Conventional Commits
- Format: type(scope): subject
- Types: feat, fix, docs, style, refactor, test, chore
- Reference issues in commit body

## Security First
- Never commit secrets, API keys, or credentials
- Use environment variables for configuration
- Validate all user inputs
- Audit dependencies regularly

## Self-Review Before PR
- Run all quality checks locally
- Verify test coverage
- Check for TODOs and commented code
- Review your own diff
```

## Hooks

Hooks are automated actions that run at specific points in the development workflow.

### Types of Hooks

#### 1. Pre-flight Hooks

Run **before** AI generates code to validate context.

**Use Cases**:
- Check if tests exist for the module being modified
- Verify required environment is set up
- Confirm specs/ADRs exist for the feature
- Validate branch naming convention

**Example Configuration** (pseudo-code):
```yaml
pre_flight_hooks:
  - name: verify_tests_exist
    trigger: before_code_generation
    condition: modifying_existing_file
    action: |
      if test_file_missing:
        warn("No test file found. Create tests/file.test.ts first?")
    
  - name: verify_spec_exists
    trigger: before_feature_implementation
    condition: feature_flag_detected
    action: |
      if spec_file_missing:
        error("Create SPEC-<feature>.md before implementing")
```

#### 2. Post-generation Hooks

Run **after** AI generates code to validate and enhance.

**Use Cases**:
- Run tests automatically
- Check coverage
- Auto-fix linting issues
- Run self-review rubric
- Update documentation

**Example Configuration** (pseudo-code):
```yaml
post_generation_hooks:
  - name: auto_test
    trigger: after_code_generation
    action: |
      run("npm run test")
      if failed:
        show_failures()
        ask_to_fix()
  
  - name: auto_lint_fix
    trigger: after_code_generation
    action: |
      run("npm run lint:fix")
      run("npm run format:fix")
      stage_changes()
  
  - name: self_review
    trigger: after_code_generation
    action: |
      run_rubric([
        "correctness",
        "completeness",
        "complexity",
        "performance",
        "security"
      ])
      generate_review_summary()
```

#### 3. PR Hooks

Run when creating or updating pull requests.

**Use Cases**:
- Generate comprehensive PR descriptions
- Link Linear issues
- Add appropriate labels
- Request reviewers based on CODEOWNERS
- Trigger preview deployments

**Example Configuration** (pseudo-code):
```yaml
pr_hooks:
  - name: generate_pr_description
    trigger: pr_creation
    action: |
      description = generate({
        problem: extract_from_spec(),
        approach: summarize_commits(),
        changes: list_changed_files(),
        test_plan: extract_from_tests(),
        risks: analyze_breaking_changes(),
      })
      set_pr_body(description)
  
  - name: link_linear_issue
    trigger: pr_creation
    action: |
      issue = extract_from_branch_name()
      if issue:
        add_pr_link_to_linear(issue)
        add_linear_link_to_pr(issue)
```

### Hook Best Practices

**1. Keep Hooks Fast**
- Pre-flight: <5 seconds
- Post-generation: <30 seconds
- Consider caching and incremental checks

**2. Make Hooks Idempotent**
```python
# ❌ Bad: Can cause infinite loops
def post_generation_hook():
    generate_more_code()  # Triggers another post-generation hook!

# ✅ Good: Deterministic and finite
def post_generation_hook():
    run_tests()
    check_coverage()
    report_results()
```

**3. Provide Clear Feedback**
```python
# ❌ Bad
def hook():
    if check_failed():
        return False

# ✅ Good
def hook():
    if check_failed():
        print("❌ Hook failed: Tests did not pass")
        print("Failed tests: test_user_login, test_checkout")
        print("Run 'npm run test' to see details")
        return False
```

**4. Allow Bypassing (with Audit)**
```bash
# For emergencies, allow bypass with explanation
git commit --no-verify -m "fix: hotfix for production issue

Bypassing hooks due to P0 incident #1234.
Will address test failures in follow-up PR.
"
```

**5. Monitor Hook Performance**
```yaml
hook_monitoring:
  - Track execution time
  - Alert if >30s
  - Log failures
  - Report success rate
```

## Memory Management

Memory stores persistent context that survives across sessions.

### What to Store

#### Architecture Decisions
```markdown
# .cursor/memory/architecture.md

## System Architecture

- Monorepo with npm workspaces
- Shared packages: @company/ui, @company/utils
- Microservices: auth, payments, notifications
- Event-driven communication via RabbitMQ
- PostgreSQL for relational data, Redis for caching

## Technology Stack

- Frontend: React 18, TypeScript, Vite
- Backend: Node.js, Express, TypeScript
- Testing: Vitest, Playwright
- Deployment: Cloudflare Pages (frontend), Kubernetes (backend)
```

#### Constraints
```markdown
# .cursor/memory/constraints.md

## Technical Constraints

- Must support IE11 (legacy customers)
- Response time <200ms for API calls
- Support offline mode for mobile app
- Maximum bundle size: 500KB (gzipped)

## Business Constraints

- PCI DSS compliance required
- GDPR compliant (EU users)
- 99.9% uptime SLA
- Support 10K concurrent users

## Team Constraints

- 5 engineers, 2 contractors
- Deploy once per week (Fridays)
- On-call rotation
```

#### Vocabulary
```markdown
# .cursor/memory/vocabulary.md

## Domain Terms

- **Listing**: A property available for rent
- **Booking**: A reservation made by a guest
- **Host**: Property owner
- **Guest**: Person making a booking
- **Payout**: Money transferred to host

## Technical Terms

- **IAM**: Internal Access Management (our custom auth system)
- **EventBus**: Our RabbitMQ-based event system
- **Cache Layer**: Redis cluster with 3 nodes

## Abbreviations

- PRD: Product Requirements Document
- ADR: Architecture Decision Record
- SPEC: Technical specification
- E2E: End-to-end (tests)
```

#### Naming Conventions
```markdown
# .cursor/memory/conventions.md

## File Naming

- Components: PascalCase (UserProfile.tsx)
- Utilities: camelCase (formatDate.ts)
- Tests: *.test.ts or *.spec.ts
- Styles: ComponentName.module.css

## Code Naming

- Classes: PascalCase
- Functions: camelCase
- Constants: UPPER_SNAKE_CASE
- Types/Interfaces: PascalCase with I prefix for interfaces (IUser)

## Database

- Tables: snake_case, plural (users, bookings)
- Columns: snake_case (created_at, user_id)
- Indexes: idx_<table>_<column>

## API Endpoints

- RESTful: /api/v1/users, /api/v1/bookings/:id
- Versioned: /api/v1, /api/v2
- Plural resources
```

### What NOT to Store

❌ **Secrets**
```markdown
# ❌ BAD - Never store in memory
AWS_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE
DATABASE_URL=postgres://user:password@localhost/db
```

❌ **Volatile Paths**
```markdown
# ❌ BAD - Paths change frequently
User's current file: /home/user/project/src/components/temp/UserProfile.tsx
```

❌ **Implementation Details**
```markdown
# ❌ BAD - Code documents itself
Function calculateTotal:
  - Line 23: Loop through items
  - Line 24: Sum prices
  - Line 25: Apply tax
```

❌ **Temporary Experiments**
```markdown
# ❌ BAD - Ephemeral context
Trying out library X for feature Y
Results: Not sure yet, needs more testing
```

### Memory Organization

```
.cursor/
  memory/
    index.md                  # Router to other memory files
    architecture.md           # System design
    constraints.md            # Limits and requirements
    vocabulary.md             # Domain terms
    conventions.md            # Naming and style
    decisions/               # Individual ADRs
      001-use-vitest.md
      002-monorepo.md
      003-event-driven.md
    integrations/            # Third-party services
      stripe.md
      supabase.md
      vercel.md
```

### Index File Pattern

Create a short index that routes AI to detailed docs:

```markdown
# .cursor/memory/index.md

## Quick Reference

- **Architecture**: See architecture.md for system design
- **Constraints**: See constraints.md for technical/business limits
- **Vocabulary**: See vocabulary.md for domain terms
- **Decisions**: See decisions/ for ADRs
- **Conventions**: See conventions.md for naming standards

## Current Focus

We're building a booking system for vacation rentals.

Key files:
- Backend: src/services/booking/
- Frontend: packages/web/src/features/booking/
- Database: migrations/2024_01_booking_schema.sql

Recent decisions:
- ADR-005: Use optimistic locking for concurrent bookings
- ADR-006: Implement idempotency with request IDs

## Red Flags

- DO NOT modify legacy payment code (src/legacy/payments/)
- DO NOT add dependencies without security review
- DO NOT deploy on Fridays (SLA requirement)
```

### Memory Maintenance

**Quarterly Review**:
```markdown
# Memory Review Checklist (Q4 2024)

- [ ] Archive obsolete decisions (mark as superseded)
- [ ] Update technology stack versions
- [ ] Refresh constraints (any SLA changes?)
- [ ] Prune vocabulary (remove unused terms)
- [ ] Verify conventions (still following them?)
- [ ] Update integration docs (API changes?)
```

**Version Control**:
```bash
# Track memory changes
git add .cursor/memory/
git commit -m "docs: update memory with new architecture decisions"
```

## Background Agents

Background agents handle long-running tasks that don't require immediate feedback.

### Use Cases

#### 1. Dependency Updates
```yaml
agent: dependency_updater
schedule: weekly
tasks:
  - Check for dependency updates
  - Read release notes and changelogs
  - Assess breaking changes
  - Run full test suite
  - Create PR with risk assessment
```

#### 2. Large Refactors
```yaml
agent: refactoring_agent
trigger: manual
tasks:
  - Rename function across codebase
  - Update all references
  - Update tests
  - Update documentation
  - Run full test suite
  - Create PR with migration guide
```

#### 3. Documentation Generation
```yaml
agent: doc_generator
schedule: post-merge
tasks:
  - Generate API documentation
  - Update OpenAPI spec
  - Generate SDK documentation
  - Update README if public APIs changed
  - Commit to docs branch
```

#### 4. Preview Deploy Orchestration
```yaml
agent: preview_deployer
trigger: pr_opened, pr_updated
tasks:
  - Build application
  - Deploy to Cloudflare Pages
  - Run smoke tests on preview
  - Comment preview URL on PR
  - Report build time and size
```

### Communication Patterns

**Progress Updates**:
```markdown
<!-- Posted as PR comment -->
🤖 Background Agent: Dependency Update

Status: In Progress (2/4 steps complete)

✅ Checked for updates (found 23 updates)
✅ Read release notes (3 breaking changes found)
⏳ Running test suite... (tests/unit: 45/100 complete)
⏳ Awaiting: Risk assessment

ETA: 5 minutes

[View logs](link) | [Cancel](link)
```

**Success**:
```markdown
🤖 Background Agent: Dependency Update

Status: ✅ Complete

Summary:
- 23 dependencies updated
- 3 breaking changes handled
- All tests passing (100% success rate)
- Coverage maintained at 85%

PR: #456 (ready for review)

Changes:
- Major: typescript@4.9 → @5.0 (migration notes included)
- Minor: vite@4.3 → @4.5, react@18.2 → @18.3
- Patch: 20 other dependencies

[View PR](link) | [View diff](link)
```

**Failure**:
```markdown
🤖 Background Agent: Dependency Update

Status: ❌ Failed

Error: Tests failed after updating dependencies

Failed tests:
- test_user_authentication (TypeError: undefined method)
- test_booking_flow (AssertionError: expected 200, got 404)

Root cause:
Axios@1.5 changed behavior of interceptors (breaking change)

Suggested fix:
Update interceptor configuration per migration guide:
https://github.com/axios/axios/blob/v1.5.0/UPGRADE_GUIDE.md#interceptors

Actions:
- [ ] Review failed tests
- [ ] Apply suggested fix
- [ ] Retry agent

[View logs](link) | [Create issue](link) | [Retry](link)
```

### Agent Configuration

```yaml
# .cursor/background-agents.yml

agents:
  - name: dependency_updater
    schedule: "0 0 * * MON"  # Monday midnight
    timeout: 30m
    tasks:
      - name: check_updates
        command: npm outdated
      - name: create_pr
        command: npm update && npm test && create-pr
    on_failure:
      - create_issue
      - notify: "#engineering"
  
  - name: test_runner
    trigger: file_change
    debounce: 5s
    tasks:
      - name: run_affected_tests
        command: npm run test:affected
    on_failure:
      - notify_author
```

### Best Practices

**1. Set Clear Success Criteria**
```yaml
# ✅ Good
success_criteria:
  - all_tests_pass: true
  - coverage_maintained: true
  - no_high_severity_vulnerabilities: true

# ❌ Bad
success_criteria:
  - looks_good: true
```

**2. Implement Retry Logic**
```python
def run_task(max_retries=3, backoff=2):
    for attempt in range(max_retries):
        try:
            result = execute_task()
            return result
        except TransientError as e:
            if attempt < max_retries - 1:
                sleep(backoff ** attempt)
                continue
            raise
```

**3. Report Status Frequently**
```python
def long_running_task():
    total_steps = 100
    for i in range(total_steps):
        execute_step(i)
        
        # Report every 10 steps or 1 minute
        if i % 10 == 0 or time_since_last_report() > 60:
            report_progress(i, total_steps)
```

**4. Enable Cancellation**
```python
def cancellable_task():
    while not cancelled():
        execute_work()
        
        if should_stop():
            cleanup()
            report_cancelled()
            return
```

## Best Practices

### 1. Start Simple, Iterate

Begin with minimal rules:
```markdown
# .cursorrules (v1)

- Always run tests after code changes
- Use npm only
- Follow ESLint rules
```

Add more as needs arise:
```markdown
# .cursorrules (v2)

- Always run tests after code changes (npm run test)
- Use npm only (never yarn or pnpm)
- Follow ESLint rules (npm run lint)
- Update documentation for user-facing changes
- Use conventional commits
```

### 2. Make Rules Observable

Track rule adherence:
```yaml
metrics:
  - rule: "always_run_tests"
    compliance: 95%
  - rule: "conventional_commits"
    compliance: 87%
  - rule: "update_documentation"
    compliance: 72%  # Needs improvement!
```

### 3. Review Regularly

Quarterly checklist:
- [ ] Are rules still relevant?
- [ ] Are rules being followed?
- [ ] Are there new patterns to codify?
- [ ] Can any rules be removed?
- [ ] Do new team members understand rules?

### 4. Document Exceptions

When rules don't apply:
```markdown
## Exceptions

### Tests
- Legacy code in `src/legacy/` exempt from coverage requirements
- E2E tests optional for internal tools

### Commits
- Merge commits from dependency bots don't need conventional format
- Hotfix commits can bypass pre-commit hooks (with documentation)
```

### 5. Align with Team

- Review rules in team meetings
- Get consensus before adding strict rules
- Make rules visible (README, onboarding docs)
- Provide rationale for each rule

## Example Configurations

### Minimal Starter

```markdown
# .cursorrules

- Run tests after every code change
- Use ESLint and Prettier
- Write descriptive commit messages
```

### Full Production Setup

See `/examples/full-production-cursorrules.md` for a comprehensive example.

## Troubleshooting

### Rules Not Being Followed

1. **Make rules more specific**
   - ❌ "Write tests"
   - ✅ "Run `npm run test` after changing any .ts file"

2. **Add examples**
   - Show good and bad examples

3. **Use hooks for enforcement**
   - Post-generation hooks can verify compliance

### Hooks Running Too Slow

1. **Profile hook execution**
   ```bash
   time run-hook post-generation
   ```

2. **Optimize slow steps**
   - Cache dependencies
   - Run only affected tests
   - Parallelize where possible

3. **Consider async for long tasks**
   - Move to background agent if >30s

### Memory Getting Stale

1. **Set review reminders**
   ```bash
   # Add to calendar
   "Review Cursor memory" - Quarterly
   ```

2. **Track last-updated dates**
   ```markdown
   # architecture.md
   Last updated: 2024-01-15
   ```

3. **Archive obsolete content**
   ```bash
   .cursor/memory/archive/2023/
   ```

## Resources

- [Cursor Documentation](https://cursor.sh/docs)
- [Example Rules Repository](https://github.com/example/cursor-rules)
- [Rule Templates](/templates/cursor-rules/)
- [Hook Examples](/examples/hooks/)

## Summary

- **Rules**: Define what agents must do
- **Hooks**: Automate validation and enhancement
- **Memory**: Provide persistent context
- **Background Agents**: Handle long-running tasks

Start simple, measure effectiveness, and iterate. The goal is to make AI agents reliable, productive teammates.