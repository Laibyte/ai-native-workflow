# ADR-XXX: [Short Title]

**Status**: Proposed | Accepted | Deprecated | Superseded  
**Date**: YYYY-MM-DD  
**Author**: [Your Name]  
**Deciders**: [Names of people involved in decision]

## Context

[Describe the issue or situation that requires a decision. Include relevant background, constraints, and forces at play.]

### Problem

[What is the specific problem we're trying to solve?]

### Forces

[What factors influence this decision?]
- [Force 1: e.g., Performance requirements]
- [Force 2: e.g., Team expertise]
- [Force 3: e.g., Budget constraints]
- [Force 4: e.g., Time to market]

## Decision

[State the decision clearly and concisely]

We will [decision].

### Rationale

[Explain why this decision was made. What were the key factors?]

1. **[Key reason 1]**: [Explanation]
2. **[Key reason 2]**: [Explanation]
3. **[Key reason 3]**: [Explanation]

## Options Considered

### Option 1: [Name]

**Description**: [Brief description of this option]

**Pros**:
- ✅ [Advantage 1]
- ✅ [Advantage 2]
- ✅ [Advantage 3]

**Cons**:
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]
- ❌ [Disadvantage 3]

**Cost**: [Time, money, complexity]

### Option 2: [Name]

[Same structure as Option 1]

### Option 3: [Name]

[Same structure as Option 1]

## Decision Matrix

| Criteria | Weight | Option 1 | Option 2 | Option 3 |
|----------|--------|----------|----------|----------|
| Performance | 9 | 7 | 5 | 9 |
| Cost | 7 | 8 | 4 | 6 |
| Maintainability | 8 | 6 | 9 | 5 |
| Team Expertise | 6 | 9 | 7 | 4 |
| Time to Implement | 5 | 5 | 8 | 3 |
| **Total** | - | **X** | **Y** | **Z** |

*Scores are 1-10, with 10 being best. Multiply by weight and sum for total.*

## Consequences

### Positive Consequences

- ✅ [Benefit 1]
- ✅ [Benefit 2]
- ✅ [Benefit 3]

### Negative Consequences

- ⚠️ [Trade-off 1]
- ⚠️ [Trade-off 2]

### Risks

- ⚠️ [Risk 1 and mitigation strategy]
- ⚠️ [Risk 2 and mitigation strategy]

## Implementation

### Required Changes

- [Change 1: e.g., Update database schema]
- [Change 2: e.g., Refactor authentication service]
- [Change 3: e.g., Update deployment scripts]

### Migration Plan

1. [Step 1]
2. [Step 2]
3. [Step 3]

### Rollback Plan

[How can we undo this decision if it doesn't work out?]

## Validation

### Success Criteria

- [ ] [How will we know this decision was correct?]
- [ ] [What metrics will we track?]
- [ ] [What feedback will we collect?]

### Review Date

[When will we revisit this decision? Default: 6 months]

## References

- [Link to related ADRs]
- [Link to technical documentation]
- [Link to research or benchmarks]
- [Link to discussion threads]

## Notes

[Any additional context, meeting notes, or discussions]

---

## Example: ADR-001: Use Vitest for Unit Testing

**Status**: Accepted  
**Date**: 2024-01-15  
**Author**: Engineering Team  
**Deciders**: Tech Lead, Senior Engineers

### Context

Our TypeScript/JavaScript projects need a fast, reliable unit testing framework. We're building several new services and need to standardize on a testing solution.

#### Problem

Current state:
- No standardized testing framework
- Jest used in some projects, Mocha in others
- Test suites are slow (>5 minutes for small projects)
- Modern ESM syntax requires workarounds

#### Forces

- **Speed**: Tests run frequently in dev and CI
- **Developer Experience**: Fast feedback loop critical
- **Ecosystem**: Need good TypeScript and React support
- **Migration Cost**: Some projects already using Jest
- **Team Familiarity**: Team knows Jest well

### Decision

We will use **Vitest** as the standard unit testing framework for all new TypeScript/JavaScript projects.

#### Rationale

1. **Performance**: Vitest is 10-20x faster than Jest for our typical project size
2. **ESM Native**: No configuration needed for ESM syntax
3. **Vite Integration**: Shares Vite config, eliminating duplication
4. **Jest Compatible**: Migration from Jest is straightforward
5. **Modern Features**: Built-in TypeScript support, native ESM, fast watch mode

### Options Considered

#### Option 1: Jest

**Pros**:
- ✅ Mature ecosystem
- ✅ Large community
- ✅ Team already familiar
- ✅ Many plugins available

**Cons**:
- ❌ Slow for our project sizes
- ❌ ESM support requires configuration
- ❌ Duplicate config with Vite

**Cost**: Low (current solution)

#### Option 2: Vitest

**Pros**:
- ✅ Very fast (10-20x faster than Jest)
- ✅ Native ESM support
- ✅ Vite config reuse
- ✅ Jest-compatible API
- ✅ Excellent TypeScript support

**Cons**:
- ❌ Newer, smaller ecosystem
- ❌ Some Jest plugins unavailable
- ❌ Team needs to learn minor differences

**Cost**: Medium (migration effort for existing projects)

#### Option 3: Node.js Test Runner

**Pros**:
- ✅ Built into Node.js
- ✅ No additional dependency
- ✅ Fast

**Cons**:
- ❌ Limited features
- ❌ No watch mode
- ❌ Poor TypeScript support
- ❌ Minimal ecosystem

**Cost**: Low, but high ongoing friction

### Decision Matrix

| Criteria | Weight | Jest | Vitest | Node Test |
|----------|--------|------|--------|-----------|
| Speed | 9 | 5 | 10 | 9 |
| Features | 8 | 9 | 8 | 4 |
| TypeScript Support | 8 | 7 | 10 | 5 |
| Ecosystem | 6 | 10 | 7 | 3 |
| Vite Integration | 7 | 4 | 10 | 4 |
| **Total** | - | **282** | **357** | **207** |

### Consequences

#### Positive Consequences

- ✅ Significantly faster test runs (saves 30+ min/day per developer)
- ✅ Better developer experience with fast watch mode
- ✅ Simplified config by reusing Vite setup
- ✅ Future-proof with ESM-first approach

#### Negative Consequences

- ⚠️ Need to migrate existing Jest projects (gradual migration acceptable)
- ⚠️ Some Jest-specific plugins may not be available

#### Risks

- ⚠️ **Risk**: Vitest is newer and may have undiscovered bugs
  - **Mitigation**: Use stable releases, report issues to maintainers
- ⚠️ **Risk**: Team unfamiliar with Vitest
  - **Mitigation**: API is 95% Jest-compatible, migration guide provided

### Implementation

#### Required Changes

- Add Vitest to TypeScript/JavaScript project templates
- Update CONTRIBUTING.md with Vitest examples
- Create migration guide for Jest → Vitest
- Update CI workflows to use Vitest

#### Migration Plan

1. All new projects use Vitest
2. Existing projects migrate opportunistically
3. Complete migration target: Q2 2024

#### Rollback Plan

If critical issues arise:
1. Continue supporting Jest for affected projects
2. Evaluate alternative solutions
3. Revisit decision in 3 months

### Validation

#### Success Criteria

- [ ] Test runs are >5x faster than Jest baseline
- [ ] Developer satisfaction score >4/5
- [ ] Zero blockers preventing daily work
- [ ] 80% of projects migrated by Q2 2024

#### Review Date

2024-07-15 (6 months)

### References

- [Vitest Documentation](https://vitest.dev)
- [Jest to Vitest Migration Guide](https://vitest.dev/guide/migration.html)
- [Performance Benchmarks](internal link)
- [Team Discussion Thread](internal link)
