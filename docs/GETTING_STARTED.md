# Getting Started with AI-Native Development Workflow

Quick start guide to adopting the AI-Native Development Workflow with Cursor IDE.

## Overview

This workflow enables you to work effectively with AI agents as teammates, with:
- 🤖 AI-optimized project templates
- ✅ Enforced quality gates (tests, linting, types)
- 🚀 Automated CI/CD with preview deploys
- 📝 Spec-driven development
- 🔒 Security and governance built-in

## Quick Start (5 minutes)

### 1. Choose Your Template

Pick the template that matches your project:

**TypeScript/JavaScript**:
```bash
cp -r templates/typescript my-project
cd my-project
npm install
npm test
```

**Python**:
```bash
cp -r templates/python my-project
cd my-project
poetry install
poetry run pytest
```

**React** (Coming Soon):
```bash
cp -r templates/react my-app
cd my-app
npm install
npm run dev
```

### 2. Configure Cursor

**Add Project Rules**:
1. Open your project in Cursor
2. The `.cursorrules` file is already included
3. Review and customize for your needs

**Configure MCP Servers** (optional):
1. Cursor Settings → Advanced → MCP Servers
2. Add servers you need (Supabase, Stripe, etc.)
3. See [MCP_GUIDE.md](./MCP_GUIDE.md) for details

### 3. Set Up CI/CD

**GitHub Actions**:
```bash
# Already included in templates!
# Just push to GitHub and workflows run automatically
git init
git add .
git commit -m "feat: initial commit"
git remote add origin <your-repo>
git push -u origin main
```

**Branch Protection**:
1. GitHub repo → Settings → Branches
2. Add rule for `main` branch
3. Enable required checks (tests, linting)
4. See [GOVERNANCE.md](./GOVERNANCE.md) for recommended settings

### 4. Start Developing

**Create a Feature**:
```bash
git checkout -b feat/user-authentication
```

**Use Prompt Frameworks**:
```markdown
/feature user-authentication

## Requirements
- JWT-based authentication
- Password reset flow
- Email verification

## Tests Required
- Unit tests for auth functions
- Integration tests for API endpoints
- E2E tests for login flow
```

**Commit with Conventional Commits**:
```bash
git commit -m "feat(auth): add JWT authentication

Implements JWT-based authentication with secure token management.
Includes password hashing with bcrypt and token refresh mechanism.

Closes #123"
```

### 5. Create PR

The AI agent prepares a complete PR for you:
- Full description with context
- Test plan and coverage
- Security and performance considerations
- Preview deployment link (auto-added by CI)

Review the [PR template](../templates/pr-templates/PULL_REQUEST_TEMPLATE.md) for details.

## Core Concepts

### 1. Spec-Driven Development

**Before coding, write a spec**:
```bash
cp templates/specs/SPEC_TEMPLATE.md specs/SPEC-user-auth.md
# Fill in: problem, approach, test plan
```

AI agents use specs to:
- Understand requirements
- Generate accurate code
- Create comprehensive tests
- Update documentation

### 2. AI Self-Review

Before requesting human review, the AI reviews its own work:
- Correctness: Logic, edge cases, errors
- Completeness: Tests, docs, types
- Complexity: Is it simple enough?
- Performance: Any bottlenecks?
- Security: Any vulnerabilities?

### 3. Testing as Default

AI agents always run tests:
```bash
# After generating/modifying code
npm run test        # or: poetry run pytest

# If tests fail, agent fixes them
# If tests missing, agent adds them
```

Coverage threshold: **≥80%** for new code

### 4. Quality Gates

All PRs must pass:
- ✅ Linting (ESLint/Ruff)
- ✅ Formatting (Prettier/Black)
- ✅ Type checking (TypeScript/mypy)
- ✅ Tests (all passing)
- ✅ Coverage threshold
- ✅ Security scan
- ✅ Build succeeds

### 5. Conventional Commits

Format: `type(scope): subject`

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `refactor`: Code restructuring
- `test`: Tests
- `chore`: Build, dependencies

**Example**:
```bash
feat(auth): add password reset flow
fix(cart): resolve race condition in checkout
docs(api): update authentication endpoints
```

### 6. Dependency Management

**Automated updates via Renovate/Dependabot**:
- Patch/minor: Auto-merged (if tests pass)
- Major: Requires review
- Security: High priority

See [Renovate config](../configs/renovate/renovate.json)

## Workflows

### Feature Development

1. **Create SPEC**: Define requirements
2. **Create branch**: `feat/feature-name`
3. **Prompt AI**: Use feature framework
4. **Generate code**: AI implements with tests
5. **Self-review**: AI reviews against rubric
6. **Create PR**: Complete description
7. **Human review**: Focus on design/logic
8. **Merge**: Deploy automatically

### Bug Fix

1. **Create issue**: Describe bug with reproduction
2. **Create branch**: `fix/bug-description`
3. **Prompt AI**: Use bug fix framework
4. **Add regression test**: Prevent recurrence
5. **Fix bug**: AI generates fix
6. **Verify**: Tests pass, bug resolved
7. **Create PR**: With test evidence
8. **Merge**: Deploy fix

### Refactoring

1. **Document goal**: What and why
2. **Create branch**: `refactor/area`
3. **Prompt AI**: Use refactoring framework
4. **Refactor**: AI restructures code
5. **Verify**: All tests pass (no behavior change)
6. **Create PR**: Explain improvement
7. **Review**: Focus on design improvement
8. **Merge**: Enjoy cleaner code

## Best Practices

### Do's ✅

1. **Write specs before code**
   - Clarifies requirements
   - Guides AI generation
   - Serves as documentation

2. **Use prompt frameworks**
   - Provides structure
   - Ensures completeness
   - Improves AI output

3. **Let AI run tests**
   - Catches bugs early
   - Ensures coverage
   - Validates correctness

4. **Review AI self-review**
   - Understand AI's assessment
   - Verify completeness
   - Learn from analysis

5. **Follow conventional commits**
   - Enables automation
   - Improves clarity
   - Powers changelogs

6. **Update docs with code**
   - Keeps docs current
   - Helps onboarding
   - Reduces questions

### Don'ts ❌

1. **Don't skip specs**
   - Leads to unclear requirements
   - Results in rework
   - Wastes time

2. **Don't bypass quality gates**
   - Accumulates technical debt
   - Introduces bugs
   - Degrades code quality

3. **Don't commit secrets**
   - Security vulnerability
   - Difficult to rotate
   - Compliance risk

4. **Don't ignore test failures**
   - Indicates real problems
   - Signals regression
   - Blocks confidence

5. **Don't merge without review**
   - Misses issues
   - Loses knowledge sharing
   - Reduces quality

## Common Tasks

### Add a Dependency

**TypeScript/JavaScript**:
```bash
npm install package-name
# or for dev dependency
npm install -D package-name

# Commit
git add package.json package-lock.json
git commit -m "chore(deps): add package-name"
```

**Python**:
```bash
poetry add package-name
# or for dev dependency
poetry add --group dev package-name

# Commit
git add pyproject.toml poetry.lock
git commit -m "chore(deps): add package-name"
```

### Run Tests

**TypeScript/JavaScript**:
```bash
npm test              # Run once
npm run test:watch    # Watch mode
npm run test:coverage # With coverage
```

**Python**:
```bash
poetry run pytest              # Run once
poetry run pytest --cov        # With coverage
poetry run pytest -k test_name # Specific test
```

### Fix Linting

**TypeScript/JavaScript**:
```bash
npm run lint:fix     # Auto-fix linting
npm run format:fix   # Auto-fix formatting
```

**Python**:
```bash
poetry run ruff check --fix  # Auto-fix linting
poetry run black .           # Auto-format
poetry run isort .           # Sort imports
```

### Update Dependencies

**Manual**:
```bash
# TypeScript/JavaScript
npm update
npm audit fix

# Python
poetry update
```

**Automated** (Recommended):
- Renovate creates PRs automatically
- Review and merge
- See [dependency management](../configs/renovate/README.md)

### Deploy Preview

**Automatic** (via CI):
- Push to PR branch
- CI builds and deploys
- Preview URL added to PR comment

**Manual**:
```bash
# Vercel
vercel deploy

# Cloudflare Pages
npx wrangler pages publish dist
```

## Troubleshooting

### Tests Failing

```bash
# Run with verbose output
npm run test -- --verbose

# Run specific test
npm run test -- path/to/test.ts

# Clear cache
npm run clean
npm install
```

### CI Failing

1. Run same checks locally:
   ```bash
   npm run lint
   npm run typecheck
   npm run test
   npm run build
   ```

2. Check CI logs for specific error

3. Fix locally and push

### Pre-commit Hook Blocking

```bash
# Auto-fix what can be fixed
npm run lint:fix
npm run format:fix

# If emergency, bypass (with documentation)
git commit --no-verify -m "fix: emergency hotfix

Bypassing hooks due to P0 incident #1234
Will address in follow-up PR #1235"
```

### AI Agent Not Following Rules

1. Check `.cursorrules` is present
2. Verify rules are clear and specific
3. Provide more context in prompt
4. Use prompt frameworks
5. Review [PROMPT_GUIDE.md](./PROMPT_GUIDE.md)

## Next Steps

### Learn More

- [Architecture](./ARCHITECTURE.md): System design
- [Contributing](./CONTRIBUTING.md): Development workflow
- [Security](./SECURITY.md): Security practices
- [Governance](./GOVERNANCE.md): Policies and standards
- [Code Review](./CODE_REVIEW.md): Review workflows
- [Prompt Guide](./PROMPT_GUIDE.md): Effective prompting
- [MCP Guide](./MCP_GUIDE.md): Extend Cursor capabilities

### Customize

1. **Adjust rules**: Edit `.cursorrules` for your needs
2. **Configure CI**: Modify workflows in `.github/workflows/`
3. **Set up MCP**: Add servers for your stack
4. **Tune automation**: Adjust Renovate config
5. **Add templates**: Create project-specific SPECs/ADRs

### Join Community

- Share your experience
- Contribute improvements
- Ask questions
- Help others

## Summary

You're now ready to:
- ✅ Work with AI agents as teammates
- ✅ Use spec-driven development
- ✅ Maintain high code quality
- ✅ Ship faster with confidence
- ✅ Follow security best practices

**Remember**: AI agents are tools that amplify your abilities. Use them wisely, review their work, and continuously improve your workflow.

Happy coding! 🚀
