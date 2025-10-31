# Architecture

## System Overview

The AI-Native Development Workflow is designed as a layered system that enables humans and AI agents to collaborate efficiently while maintaining high code quality, security, and velocity.

## Design Principles

### 1. AI Agents as First-Class Teammates
- Agents have clear responsibilities and authority boundaries
- They operate with the same tools and workflows as humans
- Context is provided through rules, memory, and documentation
- Decisions are auditable and reversible

### 2. Enforced Quality Gates
- Tests run automatically on every change
- Linting, formatting, and type checking are non-negotiable
- CI/CD pipelines provide fast feedback
- Preview deployments enable quick validation

### 3. Spec-Driven Development
- Work begins with specifications (SPECs, ADRs, RFCs)
- Implementations follow documented patterns
- Decisions are recorded for future reference
- Context accumulates over project lifetime

### 4. Minimal Configuration, Maximum Convention
- Opinionated defaults based on industry best practices
- Configuration only where variation adds value
- Templates provide known-good starting points
- Conventions reduce cognitive load

## Architecture Layers

```
┌─────────────────────────────────────────────────────────┐
│                   Developer/Agent                        │
│         (Writes code, reviews, makes decisions)         │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                  Cursor IDE Layer                        │
│  • Rules (project, user, overall)                       │
│  • Hooks (pre-flight, post-generation)                  │
│  • Memory (architecture, constraints, vocabulary)       │
│  • Background Agents (long-running tasks)               │
│  • MCP Servers (external capabilities)                  │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│              Development Workflow Layer                  │
│  • Testing (Vitest/Jest/pytest)                         │
│  • Linting (ESLint/Ruff)                                │
│  • Formatting (Prettier/Black)                          │
│  • Type Checking (TypeScript/mypy)                      │
│  • Package Management (npm/poetry)                      │
│  • Pre-commit Hooks (husky/pre-commit)                  │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                   CI/CD Layer                            │
│  • GitHub Actions                                        │
│  • Matrix builds (versions, OS)                         │
│  • Path filters (smart pipelines)                       │
│  • Artifact generation                                   │
│  • Coverage reporting                                    │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│              Deployment Layer                            │
│  • GitHub Pages (static sites)                          │
│  • Cloudflare Pages (frontend apps)                     │
│  • Preview URLs on PRs                                   │
│  • Production deployments                                │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│            Governance & Security Layer                   │
│  • Branch protection                                     │
│  • CODEOWNERS                                            │
│  • Secrets scanning                                      │
│  • Dependency audits                                     │
│  • SBOM generation                                       │
│  • SAST/DAST                                             │
└─────────────────────────────────────────────────────────┘
```

## Component Details

### Cursor Rules System

**Purpose**: Define invariants and conventions that agents must follow

**Types**:
- **Project Rules** (`.cursorrules`): Repository-specific conventions, architecture constraints, domain language
- **User Rules**: Personal preferences that apply across all projects
- **Overall Rules**: Organization-wide standards for style, security, quality

**Best Practices**:
- Keep rules specific and actionable
- Include examples for clarity
- Organize by domain (testing, security, performance, etc.)
- Version control project rules with the repository
- Review and prune rules quarterly

### Hooks System

**Purpose**: Automated checks and enhancements to AI-generated code

**Types**:
- **Pre-flight Hooks**: Validate context before generation (e.g., "tests exist for this module")
- **Post-generation Hooks**: Self-review, auto-fix, test execution
- **PR Hooks**: Generate descriptions, run self-review rubric, link Linear issues

**Implementation**:
```typescript
// Example hook structure
export interface Hook {
  name: string;
  trigger: 'pre-flight' | 'post-generation' | 'pr-creation';
  condition: (context: Context) => boolean;
  action: (context: Context) => Promise<Result>;
  idempotent: boolean;
}
```

**Best Practices**:
- Keep hooks fast (<5s for pre-flight, <30s for post-generation)
- Make hooks idempotent to avoid loops
- Provide clear error messages with actionable guidance
- Monitor hook performance and disable slow ones

### Memory System

**Purpose**: Persistent context that survives across sessions

**What to Store**:
- Architecture decisions (ADRs)
- Naming conventions and vocabulary
- Technology choices and rationale
- Performance budgets
- Security constraints
- API design patterns

**What NOT to Store**:
- Secrets or credentials
- Volatile file paths
- Implementation details (covered by code)
- Temporary experiment results

**Organization**:
```
.cursor/
  memory/
    architecture.md      # High-level system design
    constraints.md       # Technical and business constraints
    vocabulary.md        # Domain-specific terms
    decisions/           # Individual ADRs
      001-use-vitest.md
      002-monorepo-structure.md
```

**Best Practices**:
- Keep memory files focused (max 500 lines)
- Use stable filenames and structure
- Update memory when decisions change
- Create index files that route to detailed docs
- Review memory quarterly and archive obsolete content

### Background Agents

**Purpose**: Handle long-running tasks that don't require immediate feedback

**Use Cases**:
- Dependency updates (Renovate-style)
- Large refactors (renaming across codebase)
- Documentation generation
- Migration scripts
- Preview deploy orchestration

**Communication**:
- Report progress via PR comments
- Create issues for failures
- Link to logs and artifacts
- Provide rollback instructions

**Best Practices**:
- Set clear success/failure criteria
- Implement retry logic with exponential backoff
- Timeout after reasonable duration
- Report status every 5-10 minutes for long tasks
- Enable cancellation

### Package Management

**npm (TypeScript/JavaScript)**:
- Lock file: `package-lock.json`
- Version pinning: Use ranges for libraries, exact for apps
- Security: `npm audit` in CI
- Cache: `~/.npm` in CI with cache key based on lock file
- Workspaces: Monorepo support built-in

**poetry (Python)**:
- Lock file: `poetry.lock`
- Virtual env: `.venv` in project root
- Version pinning: Caret by default, exact for critical deps
- Security: `poetry audit` (via plugin)
- Cache: `~/.cache/pypoetry` in CI

**Enforcement**:
- CI fails if wrong package manager used
- Pre-commit hook validates lock files
- Agents propose updates via PRs with risk assessment

### Testing Strategy

**Unit Tests**:
- Run on every code change
- Fast (<10s for full suite)
- High coverage (>80% for new code)
- Mocked external dependencies

**Integration Tests**:
- Run on PR and main branch
- Medium speed (<2min)
- Real dependencies where feasible
- Test critical paths

**E2E Tests**:
- Run on PR (smoke tests) and main (full suite)
- Slower (<10min)
- Real browser/environment
- Focus on user journeys

**Test Selection Strategy**:
- Local: Watch mode, affected tests only
- PR: All unit tests, selective integration/E2E
- Main: Full suite including slow tests
- Nightly: Performance, security, compatibility tests

### CI/CD Pipeline Architecture

**Pipeline Stages**:
```yaml
install → lint → typecheck → test → build → deploy
   ↓        ↓        ↓         ↓       ↓       ↓
  3min     1min     2min      5min    3min   2min
```

**Optimization Techniques**:
- **Caching**: Dependencies, build artifacts, test results
- **Path Filters**: Skip pipelines when irrelevant files change
- **Matrix Builds**: Only for LTS versions and primary OS
- **Artifacts**: Share between jobs to avoid rebuilds
- **Concurrency**: Cancel outdated pipeline runs

**Preview Deployments**:
- Trigger: PR opened/updated
- Target: GitHub Pages or Cloudflare Pages
- URL: Commented on PR automatically
- Lifecycle: Deleted when PR closed/merged
- Auth: Public for open-source, protected for private

### Security Model

**Secrets Management**:
- Never commit secrets to repository
- Use GitHub Secrets for CI/CD
- Rotate secrets quarterly
- Scan commits with tools like `gitleaks`

**Permissions**:
- CI/CD: Minimal scopes (read repo, write deployments)
- Background agents: Scoped to specific tasks
- MCP servers: Least privilege principle

**Supply Chain**:
- Lock files committed
- Dependency scanning (Dependabot, Renovate)
- SBOM generation
- License compliance checks

**Code Security**:
- SAST (Static Application Security Testing)
- DAST (Dynamic Application Security Testing)
- Dependency vulnerability scanning
- Code review required

## Data Flow

### Feature Development Flow
```
1. Developer/Agent creates SPEC
   └─> Defines problem, constraints, approach

2. Agent generates implementation
   ├─> Follows project rules
   ├─> Respects memory constraints
   └─> Includes tests and docs

3. Post-generation hooks execute
   ├─> Run tests
   ├─> Check coverage
   ├─> Lint and format
   └─> Self-review against rubric

4. Agent creates PR
   ├─> Complete description
   ├─> Links to SPEC and Linear issue
   ├─> Includes test plan
   └─> Preview deploy URL

5. CI/CD pipeline runs
   ├─> All quality gates
   └─> Preview deployment

6. Human review
   ├─> Uses review packet
   └─> Validates preview

7. Merge and deploy
   ├─> Update changelog
   └─> Production deployment
```

### Dependency Update Flow
```
1. Renovate detects updates
   └─> Creates PRs with risk assessment

2. Background agent reviews
   ├─> Checks breaking changes
   ├─> Reviews release notes
   └─> Assesses impact

3. CI runs full test suite
   └─> Including E2E

4. Auto-merge or flag for review
   ├─> Patch/minor: Auto-merge if green
   └─> Major: Human review required

5. Update memory and docs
   └─> Record any API changes
```

## Technology Choices

### Why npm (not Yarn/pnpm)?
- Universal availability
- Largest ecosystem
- Workspace support built-in
- Predictable behavior
- Better CI cache stories

### Why poetry (not pip/pipenv)?
- Deterministic resolution
- Lockfile standard
- Modern pyproject.toml
- Dependency groups
- Plugin ecosystem

### Why Vitest (when to choose)?
- Fast (ES modules, modern tooling)
- Vite compatibility
- Watch mode excellent
- Choose for: New projects, Vite-based apps

### Why Jest (when to choose)?
- Mature ecosystem
- More plugins and integrations
- Better community support for edge cases
- Choose for: Large existing codebases, specific plugin needs

### Why pytest?
- Fixture system
- Parametrization
- Plugin ecosystem
- Discovery magic
- Assertion introspection

### Why Playwright (not Cypress)?
- Multi-browser support
- Modern async API
- Better performance
- Network mocking built-in
- Trace viewer

### Why ESLint + Prettier?
- Industry standard
- TypeScript support
- Extensible rules
- Auto-fix capabilities

### Why Ruff + Black?
- Speed (Ruff is 10-100x faster than flake8)
- Comprehensive rules
- Black compatibility
- Active maintenance

## Decision Records

See `docs/decisions/` for individual ADRs documenting key architectural decisions.

### ADR Index
- [ADR-001: Use npm and poetry exclusively](./decisions/ADR-001-package-managers.md)
- [ADR-002: Enforce testing as default reflex](./decisions/ADR-002-testing-automation.md)
- [ADR-003: Spec-driven development workflow](./decisions/ADR-003-spec-driven.md)
- [ADR-004: Background agents for long-running tasks](./decisions/ADR-004-background-agents.md)

## Evolution and Maintenance

### Quarterly Review
- Evaluate rule effectiveness
- Prune obsolete memory
- Update dependencies
- Review pipeline performance
- Assess security posture

### Continuous Improvement
- Monitor agent success rates
- Collect developer feedback
- Track quality metrics
- Measure cycle time
- Analyze incident patterns

### Scaling Considerations
- Monorepo vs multi-repo
- Shared vs dedicated CI resources
- Centralized vs distributed rules
- Global vs local memory
