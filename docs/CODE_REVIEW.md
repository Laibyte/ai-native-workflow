# Code Review Guide

Guide for effective code reviews in an AI-native workflow.

## Philosophy

Code reviews serve multiple purposes:
1. **Quality Gate**: Catch bugs, security issues, and design problems
2. **Knowledge Sharing**: Spread understanding across the team
3. **Standards Enforcement**: Maintain consistent code quality
4. **Learning**: Both reviewers and authors learn from the process

## AI-Assisted Review Process

### 1. AI Self-Review (Pre-Review)

Before requesting human review, the AI agent performs a self-review:

**Checklist**:
- ✅ Correctness: Logic, edge cases, error handling
- ✅ Completeness: Tests, docs, types
- ✅ Complexity: Can it be simpler?
- ✅ Performance: Any obvious bottlenecks?
- ✅ Security: Injection risks, data leaks?

**Output**: Self-review summary in PR description with confidence levels

### 2. Human Review

Humans focus on:
- Architecture and design decisions
- Business logic correctness
- Complex edge cases
- User experience
- Long-term maintainability

**What humans DON'T need to focus on** (AI handles):
- Code style (enforced by linters)
- Missing tests (CI gates)
- Documentation gaps (AI checks)
- Simple bugs (caught by tests)

## Review Packet

The AI prepares a "review packet" for efficient human review:

### Standard Review Packet Contents

```markdown
## Review Packet

### Summary
<!-- 2-3 sentence overview of the change -->

### Changed Surfaces
- **User-facing**: [List of UI/API changes]
- **Internal APIs**: [List of internal API changes]
- **Database**: [Schema changes]
- **Configuration**: [Config changes]

### Risk Assessment
- **Impact**: Low / Medium / High
- **Complexity**: Low / Medium / High
- **Breaking Changes**: Yes / No

### Dependencies
- **New**: [New dependencies]
- **Updated**: [Updated dependencies]
- **Security**: [Known vulnerabilities]

### Verification
1. [How to verify change works]
2. [How to verify nothing breaks]

### Rollback
[How to rollback if needed]

### Preview
[Link to deployed preview]
```

## Review Guidelines

### For Authors

#### Before Requesting Review

- [ ] Self-review completed
- [ ] AI self-review completed
- [ ] All CI checks pass
- [ ] Preview deployed and tested
- [ ] PR description complete
- [ ] Reviewers assigned
- [ ] Linear issue linked

#### During Review

- ✅ **Respond promptly** to comments
- ✅ **Ask clarifying questions** if feedback is unclear
- ✅ **Explain your reasoning** for design decisions
- ✅ **Be open** to suggestions
- ❌ **Don't take feedback personally**
- ❌ **Don't argue defensively**

#### After Review

- [ ] Address all feedback
- [ ] Resolve conversations
- [ ] Request re-review if needed
- [ ] Merge when approved
- [ ] Monitor deployment
- [ ] Update Linear issue

### For Reviewers

#### Review Goals

1. **Correctness**: Does it solve the problem?
2. **Quality**: Is it well-designed and maintainable?
3. **Safety**: Are there security or performance risks?
4. **Completeness**: Tests, docs, edge cases covered?

#### Review Priorities

**High Priority** (Always review):
- Architecture and design decisions
- Security implications
- Breaking changes
- Complex business logic
- Performance-critical paths

**Medium Priority** (Review when time allows):
- Code organization
- Naming and clarity
- Test coverage completeness
- Documentation quality

**Low Priority** (Trust automation):
- Code style (linters handle)
- Simple typos (CI catches)
- Missing semicolons (formatters handle)

#### Review Etiquette

✅ **DO**:
- Be kind and constructive
- Ask questions, don't demand changes
- Provide context for suggestions
- Praise good decisions
- Review promptly (within 24 hours)
- Approve when ready (don't over-optimize)

❌ **DON'T**:
- Be dismissive or condescending
- Nitpick style (let linters handle)
- Block on personal preferences
- Request changes without explanation
- Leave reviews hanging

#### Comment Types

**Question** 🤔:
```
🤔 Why did you choose approach X over Y?
```

**Suggestion** 💡:
```
💡 Consider using a map here instead of filtering twice
```

**Blocking Issue** 🚨:
```
🚨 This has a security vulnerability: [explanation]
```

**Praise** 🎉:
```
🎉 Great use of the Result pattern here!
```

**Nitpick** (non-blocking) 🔸:
```
🔸 Nitpick: This variable name could be more descriptive
```

## Review Rubric

### Correctness

- [ ] Logic is sound
- [ ] Edge cases handled
- [ ] Error handling comprehensive
- [ ] No obvious bugs
- [ ] Tests verify correctness

**Questions to ask**:
- What happens if this value is null/undefined?
- What if the network request fails?
- What if the user provides invalid input?
- What if the list is empty?

### Design

- [ ] Appropriate abstraction level
- [ ] Follows SOLID principles
- [ ] DRY (Don't Repeat Yourself)
- [ ] Single responsibility
- [ ] Easy to understand

**Questions to ask**:
- Is this the right place for this code?
- Could this be simpler?
- Is the abstraction earning its keep?
- Will this be easy to change later?

### Security

- [ ] No credentials in code
- [ ] Input validation present
- [ ] SQL injection protected
- [ ] XSS protected
- [ ] Authentication/authorization correct
- [ ] Secrets properly managed

**Questions to ask**:
- What if a malicious user supplies this input?
- Are there any injection risks?
- Is sensitive data logged or exposed?
- Are permissions checked?

### Performance

- [ ] No obvious bottlenecks
- [ ] Appropriate data structures
- [ ] Efficient algorithms
- [ ] Database queries optimized
- [ ] No N+1 queries

**Questions to ask**:
- How does this scale with data size?
- Are there unnecessary network calls?
- Could this block the event loop?
- Is caching appropriate here?

### Testing

- [ ] Tests exist
- [ ] Happy path tested
- [ ] Error cases tested
- [ ] Edge cases tested
- [ ] Coverage threshold met
- [ ] Tests are clear and maintainable

**Questions to ask**:
- What could go wrong that isn't tested?
- Are the tests easy to understand?
- Do tests test behavior, not implementation?
- Are there flaky tests?

### Documentation

- [ ] Public APIs documented
- [ ] Complex logic explained
- [ ] README updated if needed
- [ ] Migration guide (if breaking)
- [ ] ADR created (if architectural)

**Questions to ask**:
- Can someone new understand this?
- Is the "why" documented, not just the "what"?
- Will I understand this in 6 months?

## Common Review Scenarios

### Scenario: Large PR (>500 lines)

**Approach**:
1. Ask for PR to be split if possible
2. Review high-level design first
3. Review in multiple sessions
4. Focus on critical paths

**Template Comment**:
```markdown
This PR is quite large. Could we split it into:
1. Infrastructure changes
2. Core feature
3. Tests and documentation

This would make review more effective.
```

### Scenario: Breaking Change

**Approach**:
1. Verify migration guide exists
2. Check deprecation warnings
3. Verify communication plan
4. Confirm rollback plan

**Template Comment**:
```markdown
🚨 Breaking change detected. Please ensure:
- [ ] Migration guide is complete
- [ ] Deprecation warnings added
- [ ] Team notified
- [ ] Rollback plan documented
```

### Scenario: Security Concern

**Approach**:
1. Block the PR immediately
2. Explain the vulnerability clearly
3. Suggest remediation
4. Request security review if needed

**Template Comment**:
```markdown
🚨 Security Issue: This code is vulnerable to SQL injection.

**Problem**: User input is concatenated directly into SQL query.

**Fix**: Use parameterized queries:
```sql
SELECT * FROM users WHERE id = $1
```

**Resources**: [Link to security guide]
```

### Scenario: Performance Concern

**Approach**:
1. Identify the bottleneck
2. Suggest profiling if unsure
3. Propose alternative approach
4. Consider acceptable trade-offs

**Template Comment**:
```markdown
⚠️ Performance Concern: This loops over all items N times.

**Impact**: O(n²) complexity could be slow for large datasets.

**Suggestion**: Use a Map for O(n) lookup:
```typescript
const itemMap = new Map(items.map(i => [i.id, i]));
```

**Question**: What's the expected size of the dataset?
```

### Scenario: Missing Tests

**Approach**:
1. Identify untested paths
2. Explain why tests are needed
3. Suggest test cases

**Template Comment**:
```markdown
🔍 Missing test coverage for error case:

**Scenario**: What happens when the API returns 500?

**Suggested test**:
```typescript
it('should handle API errors gracefully', async () => {
  mockAPI.mockRejectedValue(new Error('Server error'));
  await expect(fetchData()).rejects.toThrow();
});
```
```

## Review Response Examples

### Accepting a Suggestion

```markdown
✅ Good catch! Implemented in [commit abc123].
```

### Respectfully Disagreeing

```markdown
I considered that approach, but chose X because [reason].

However, I'm open to Y if you feel strongly. What do you think?
```

### Asking for Clarification

```markdown
Could you elaborate on this concern? I want to make sure I understand
the issue before making changes.
```

### Explaining Your Reasoning

```markdown
I chose this pattern because:
1. [Reason 1]
2. [Reason 2]

Here's a link to the ADR: [link]

Happy to discuss alternatives if you see issues with this approach.
```

## Time Budgets

Set expectations for review turnaround:

| PR Size | Initial Review | Full Review | Re-review |
|---------|---------------|-------------|-----------|
| Small (<50 lines) | 1 hour | 2 hours | 30 min |
| Medium (50-200 lines) | 4 hours | 8 hours | 1 hour |
| Large (200-500 lines) | 1 day | 2 days | 2 hours |
| XL (>500 lines) | Split or 2+ days | 3+ days | 4 hours |

## Approval Levels

### Single Approver

**When**: Small, low-risk changes
- Documentation updates
- Simple bug fixes
- Test additions
- Refactoring with tests

### Two Approvers

**When**: Medium-risk changes
- New features
- API changes (non-breaking)
- Database migrations
- Performance optimizations

### Team Review

**When**: High-risk changes
- Breaking changes
- Architecture changes
- Security-critical code
- Core infrastructure

## After Approval

### Pre-Merge Checklist

- [ ] All conversations resolved
- [ ] CI passing
- [ ] Preview tested
- [ ] Conflicts resolved
- [ ] Changelog updated

### Merge Strategy

**Squash and Merge** (default):
- Combines commits into one
- Clean history
- Good for most PRs

**Merge Commit**:
- Preserves commit history
- Use for large features with meaningful commit messages

**Rebase and Merge**:
- Linear history
- Use for small, atomic changes

### Post-Merge

- [ ] Monitor deployment
- [ ] Check error rates
- [ ] Verify preview works in production
- [ ] Update Linear issue
- [ ] Celebrate! 🎉

## Metrics

Track review effectiveness:

- **Review Time**: Time from PR open to first review
- **Merge Time**: Time from PR open to merge
- **Back-and-Forth**: Number of review rounds
- **Defect Escape Rate**: Bugs that make it past review
- **Review Coverage**: % of PRs reviewed by >1 person

**Goals**:
- Review time: <24 hours for small PRs
- Merge time: <48 hours for small PRs
- Back-and-forth: <3 rounds
- Defect escape: <5%

## Resources

- [Code Review Best Practices](https://google.github.io/eng-practices/review/)
- [Conventional Comments](https://conventionalcomments.org/)
- [Security Review Checklist](./SECURITY.md)
- [Performance Review Checklist](./PERFORMANCE.md)

## Summary

Great code reviews:
1. ✅ Focus on design and correctness
2. ✅ Leverage AI for style and completeness
3. ✅ Are kind, constructive, and prompt
4. ✅ Catch issues before production
5. ✅ Share knowledge across the team

Poor code reviews:
1. ❌ Nitpick style (let tools handle)
2. ❌ Block on personal preferences
3. ❌ Take days to respond
4. ❌ Miss critical issues
5. ❌ Discourage contributors
