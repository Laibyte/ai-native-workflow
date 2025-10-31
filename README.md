# AI-Native Development Workflow

A comprehensive, battle-tested framework for building software with Cursor IDE and AI agents as first-class teammates. Optimized for TypeScript, JavaScript, Python, and React with enforced quality gates, predictable CI/CD, and spec-driven development.

## 🎯 Philosophy

This workflow treats AI agents as teammates who:
- **Always run tests** when code changes
- **Enforce quality gates** (linting, formatting, typing) before commits
- **Maintain documentation** as a living artifact
- **Generate complete PRs** with context, risks, and test plans
- **Self-review** before human review
- **Keep dependencies fresh** with automated proposals

## 🚀 Quick Start

### TypeScript/JavaScript Project
```bash
# Copy template
cp -r templates/typescript my-project
cd my-project
npm install
npm test
```

### Python Project
```bash
# Copy template
cp -r templates/python my-project
cd my-project
poetry install
poetry run pytest
```

Each template includes:
- Testing infrastructure (Vitest/Jest/pytest)
- Linting and formatting (ESLint+Prettier / Ruff+Black)
- CI/CD pipelines (GitHub Actions)
- Preview deployments (GitHub Pages / Cloudflare Pages)
- Cursor rules and prompts
- Security and governance defaults

## 📚 What's Included

### Core Documentation
- **[ARCHITECTURE.md](./docs/ARCHITECTURE.md)** - System design and decision rationale
- **[CONTRIBUTING.md](./docs/CONTRIBUTING.md)** - Development workflow and guidelines
- **[PROMPT_GUIDE.md](./docs/PROMPT_GUIDE.md)** - Prompt frameworks and slash commands
- **[AI_RULES.md](./docs/AI_RULES.md)** - How to configure Cursor rules, hooks, and memory

### Templates
- **[TypeScript/JavaScript](./templates/typescript/)** - Node.js projects with Vitest/Jest
- **[Python](./templates/python/)** - Poetry-based projects with pytest
- **[React](./templates/react/)** - Modern React apps with preview deploys
- **[Full-Stack](./templates/fullstack/)** - Complete apps with DB, auth, payments
- **[GitHub Pages](./templates/gh-pages/)** - Static sites
- **[Cloudflare Pages](./templates/cloudflare-pages/)** - Edge-deployed frontends

### Automation
- **[GitHub Actions Workflows](./workflows/)** - CI/CD, preview deploys, dependency updates
- **[Pre-commit Hooks](./configs/pre-commit/)** - Enforce quality before commits
- **[Renovate Configs](./configs/renovate/)** - Automated dependency proposals
- **[PR Templates](./templates/pr-templates/)** - Complete PR descriptions for AI

### Governance
- **[Security Policies](./docs/SECURITY.md)** - Secrets scanning, SBOM, SAST/DAST
- **[Code Review Guide](./docs/CODE_REVIEW.md)** - AI-assisted review workflows
- **[Governance Guide](./docs/GOVERNANCE.md)** - Branch protection, CODEOWNERS, compliance

## 🧪 Testing Automation

AI agents automatically:
- Detect your test framework and run appropriate commands
- Execute targeted tests on code changes
- Report coverage and gate PRs on quality thresholds
- Quarantine flaky tests and create follow-up tasks

**TS/JS**: Vitest (speed) or Jest (ecosystem compatibility)  
**Python**: pytest with fixtures, parametrization, coverage  
**E2E**: Playwright (recommended) or Cypress

## 📦 Package Management

**npm only** for TS/JS - No Yarn or pnpm drift  
**poetry only** for Python - No pip or conda confusion

- Lockfiles committed and enforced
- Node/Python versions pinned
- Vulnerability audits automated
- Cache strategies optimized for CI

## ✅ Quality Gates

### TypeScript/JavaScript
```bash
npm run lint      # ESLint + TypeScript-ESLint
npm run format    # Prettier
npm run typecheck # tsc --noEmit
npm run test      # Vitest/Jest
npm run test:e2e  # Playwright
```

### Python
```bash
poetry run ruff check   # Linting
poetry run black .      # Formatting
poetry run isort .      # Import sorting
poetry run mypy .       # Type checking
poetry run pytest       # Tests with coverage
```

## 🚢 CI/CD and Preview Deploys

Every PR triggers:
1. Install dependencies (with caching)
2. Lint + format check
3. Type checking
4. Unit tests + coverage
5. E2E tests (selective)
6. Preview deployment with URL in PR comment

**GitHub Pages**: Static sites, documentation  
**Cloudflare Pages**: Frontend apps, edge functions

## 🤖 Cursor Integration

### Rules
- **Project rules** (`.cursorrules`) - Repository-specific conventions
- **User rules** - Personal preferences across projects
- **Overall rules** - Organization-wide standards

### Hooks
- **Pre-flight checks** - Validate before generation
- **Post-generation review** - Self-review with rubric
- **Test triggers** - Always run tests when required

### Memory
- Architecture decisions
- Naming conventions
- Domain vocabulary
- Constraint documentation

### Background Agents
- Dependency updates
- Large refactors
- Documentation generation
- Preview deploy orchestration

## 📋 Spec-Driven Development

### Templates
- **[SPEC Template](./templates/specs/SPEC_TEMPLATE.md)** - Feature specifications
- **[ADR Template](./templates/specs/ADR_TEMPLATE.md)** - Architecture Decision Records
- **[RFC Template](./templates/specs/RFC_TEMPLATE.md)** - Request for Comments

### Workflow
1. Write SPEC with problem, constraints, approach
2. AI agent generates implementation following SPEC
3. Self-review against SPEC rubric
4. Human review with SPEC as reference
5. Update SPEC with learnings

## 🔗 Integrations

### Linear
- Auto-link issues to branches and PRs
- Sync acceptance criteria to SPECs
- Status transitions on PR events

### MCP Servers
- **Supabase** - Database schemas, migrations
- **Stripe** - Payment flows, webhooks
- **Vercel** - Hosting orchestration
- See [MCP Guide](./docs/MCP_GUIDE.md) for full list

## 📝 Conventional Commits

```
feat: add user authentication
fix: resolve memory leak in cache
docs: update API documentation
chore: upgrade dependencies
test: add coverage for edge cases
```

- Enforced via pre-commit hooks
- Powers changelog generation
- Enables semantic versioning

## 🔒 Security and Governance

- Secrets scanning before commits
- Minimal CI/CD permissions
- Branch protection rules
- CODEOWNERS enforcement
- Signed commits
- SBOM and license compliance
- SAST/DAST automation

## 📖 Documentation

### For Developers
- README, CONTRIBUTING, CODE_OF_CONDUCT
- Architecture overview and ADRs
- API documentation
- Deployment guides

### For AI
- Project rules with invariants
- Domain glossary
- Decision constraints
- Quality bars and "don'ts"
- Short index files routing to context

## 🎓 Learning Resources

- **[Testing Best Practices](./docs/TESTING.md)** - Framework choices, patterns, flake mitigation
- **[Package Management](./docs/PACKAGE_MANAGEMENT.md)** - npm and poetry deep dives
- **[CI/CD Guide](./docs/CICD.md)** - GitHub Actions patterns
- **[Prompt Engineering](./docs/PROMPT_GUIDE.md)** - Get the most from AI agents

## 🛠️ Project Initializer

Interactive scaffolding that captures:
- Language and frameworks
- Testing strategy
- CI/CD targets (GitHub Pages, Cloudflare Pages, etc.)
- Security and governance preferences
- Documentation structure
- Cursor rules and prompts

Produces a fully equipped, AI-native repository ready for development.

## 🤝 Contributing

See [CONTRIBUTING.md](./docs/CONTRIBUTING.md) for detailed guidelines.

## 📄 License

MIT - See [LICENSE](./LICENSE)

## 🙏 Acknowledgments

Built from battle-tested patterns used by experienced engineers working with Cursor IDE and AI agents across production TypeScript, JavaScript, Python, and React codebases.
