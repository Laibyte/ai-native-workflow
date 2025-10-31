# Contributing Guide

Welcome! This guide explains how to contribute to projects built with the AI-Native Development Workflow.

## 🎯 Philosophy

We treat AI agents as teammates. This means:
- Clear specifications before implementation
- Automated quality checks
- Comprehensive testing
- Complete documentation
- Self-review before human review

## 🚀 Getting Started

### Prerequisites

**For TypeScript/JavaScript projects**:
```bash
node --version    # v18+ or v20+ (see .nvmrc)
npm --version     # v9+
```

**For Python projects**:
```bash
python --version  # 3.11+ or 3.12+ (see .python-version)
poetry --version  # 1.7+
```

### Initial Setup

1. **Clone the repository**:
```bash
git clone <repository-url>
cd <repository-name>
```

2. **Install dependencies**:

For TypeScript/JavaScript:
```bash
npm install
```

For Python:
```bash
poetry install
```

3. **Verify setup**:

For TypeScript/JavaScript:
```bash
npm run lint
npm run typecheck
npm run test
```

For Python:
```bash
poetry run ruff check
poetry run mypy .
poetry run pytest
```

4. **Set up pre-commit hooks**:

For TypeScript/JavaScript:
```bash
npm run prepare  # Installs husky hooks
```

For Python:
```bash
poetry run pre-commit install
```

## 📋 Development Workflow

### 1. Start with a Spec

Before writing code, create a specification:

```bash
cp templates/specs/SPEC_TEMPLATE.md specs/SPEC-<feature-name>.md
```

Fill in:
- **Problem**: What are you solving?
- **Constraints**: What limits exist?
- **Approach**: How will you solve it?
- **Alternatives**: What else did you consider?
- **Test Plan**: How will you verify it works?

### 2. Create a Branch

Use conventional branch naming:

```bash
# Features
git checkout -b feat/user-authentication

# Bug fixes
git checkout -b fix/memory-leak-cache

# Documentation
git checkout -b docs/update-api-guide

# Refactoring
git checkout -b refactor/extract-user-service
```

### 3. Implement with Tests

**Test-Driven Development (TDD)**:
```bash
# 1. Write failing test
npm run test -- --watch

# 2. Implement feature

# 3. Make test pass

# 4. Refactor
```

**Test Coverage Requirements**:
- New code: >80% coverage
- Bug fixes: Add regression test
- Refactors: Maintain or improve coverage

### 4. Follow Code Quality Standards

**TypeScript/JavaScript**:
```bash
npm run lint       # Auto-fix: npm run lint:fix
npm run format     # Auto-fix: npm run format:fix
npm run typecheck  # No auto-fix
```

**Python**:
```bash
poetry run ruff check     # Auto-fix: ruff check --fix
poetry run black .        # Formats in place
poetry run isort .        # Sorts imports
poetry run mypy .         # Type checking
```

### 5. Write Conventional Commits

Format:
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting, whitespace
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Build, CI, dependencies

**Examples**:
```bash
git commit -m "feat(auth): add JWT authentication

Implements JSON Web Token authentication with refresh tokens.
Includes middleware for protected routes.

Closes #123"

git commit -m "fix(cache): resolve memory leak in LRU cache

The cache was not properly evicting old entries.
Added proper cleanup in eviction logic.

Fixes #456"
```

**Enforcement**:
Pre-commit hooks validate commit messages. If blocked:
```bash
# Fix the commit message
git commit --amend
```

### 6. Run Self-Review

Before pushing, review your own changes:

**Checklist**:
- [ ] All tests pass
- [ ] Coverage meets threshold
- [ ] Linting passes
- [ ] Type checking passes
- [ ] Documentation updated
- [ ] Changelog entry added (if needed)
- [ ] No sensitive data committed
- [ ] No commented-out code (unless with explanation)
- [ ] No TODOs without linked issues

**Self-Review Rubric**:
```bash
# Use the AI agent for self-review
# (Assuming Cursor with background agent)
# The agent will check:
# - Correctness: Logic, edge cases, error handling
# - Completeness: Tests, docs, types
# - Complexity: Can it be simpler?
# - Performance: Any obvious bottlenecks?
# - Security: Injection risks, data leaks?
```

### 7. Create a Pull Request

```bash
git push origin feat/user-authentication
```

**PR Title**: Follow conventional commit format
```
feat(auth): add JWT authentication
```

**PR Description**: Use the template (auto-populated)

Required sections:
- **Problem**: What issue does this address?
- **Approach**: How did you solve it?
- **Changes**: What changed?
- **Test Plan**: How to verify?
- **Risks**: What could go wrong?
- **Preview**: Link to deployed preview (auto-added by CI)

**Labels**: Add appropriate labels
- `feat`, `fix`, `docs`, `refactor`, `test`, `chore`
- `breaking` if breaking change
- `security` if security-related

**Reviewers**: Tag relevant people (auto-assigned via CODEOWNERS)

**Linear Issue**: Link the Linear issue (auto-detected from branch name)

### 8. Address Review Feedback

**Responding to Comments**:
- Be open to feedback
- Ask clarifying questions
- Explain your reasoning
- Make requested changes promptly

**Updating Your PR**:
```bash
# Make changes
git add .
git commit -m "fix(auth): address review feedback"
git push origin feat/user-authentication
```

**Resolving Conversations**:
- Resolve conversations after addressing them
- Leave a comment explaining what you changed

### 9. Merge and Deploy

After approval and passing CI:

**Squash and Merge** (default):
- Combines commits into one
- Keeps history clean
- Preserves PR link

**Merge Commit** (for multi-component changes):
- Preserves individual commits
- Use when commit history is valuable

**Rebase and Merge** (for linear history):
- Replays commits on top of main
- Use for small, atomic changes

**Post-Merge**:
- Delete your branch (auto-deleted)
- Monitor deployment
- Update Linear issue status

## 🧪 Testing Guidelines

### Unit Tests

**Location**:
- TypeScript/JavaScript: `src/**/__tests__/*.test.ts`
- Python: `tests/unit/**/*_test.py`

**Example (TypeScript)**:
```typescript
import { describe, it, expect } from 'vitest';
import { calculateTotal } from './cart';

describe('calculateTotal', () => {
  it('should calculate total with tax', () => {
    const items = [
      { price: 10, quantity: 2 },
      { price: 5, quantity: 1 }
    ];
    
    expect(calculateTotal(items, 0.1)).toBe(27.5);
  });

  it('should handle empty cart', () => {
    expect(calculateTotal([], 0.1)).toBe(0);
  });
});
```

**Example (Python)**:
```python
import pytest
from cart import calculate_total

def test_calculate_total_with_tax():
    items = [
        {"price": 10, "quantity": 2},
        {"price": 5, "quantity": 1}
    ]
    
    assert calculate_total(items, 0.1) == 27.5

def test_calculate_total_empty_cart():
    assert calculate_total([], 0.1) == 0
```

### Integration Tests

Test interactions between components:
- Database operations
- API endpoints
- Service integrations

### E2E Tests

Test complete user journeys:
- Login flow
- Checkout process
- Admin workflows

**Example (Playwright)**:
```typescript
import { test, expect } from '@playwright/test';

test('user can complete checkout', async ({ page }) => {
  await page.goto('/');
  await page.click('text=Add to Cart');
  await page.click('text=Checkout');
  
  await page.fill('#email', 'test@example.com');
  await page.fill('#card', '4242424242424242');
  await page.click('text=Complete Purchase');
  
  await expect(page.locator('text=Order Confirmed')).toBeVisible();
});
```

## 📚 Documentation Standards

### Code Comments

**When to Comment**:
- Complex algorithms
- Non-obvious decisions
- Workarounds for bugs
- Performance optimizations

**When NOT to Comment**:
- Obvious code
- Redundant descriptions
- Instead, write self-documenting code

**Example**:
```typescript
// ❌ Bad: Obvious
// Increment counter by one
counter++;

// ✅ Good: Explains why
// Increment by one to account for zero-indexed array
// but one-indexed display to users
counter++;
```

### API Documentation

**TypeScript/JavaScript (JSDoc)**:
```typescript
/**
 * Calculates the total price including tax
 * @param items - Array of cart items with price and quantity
 * @param taxRate - Tax rate as decimal (e.g., 0.1 for 10%)
 * @returns Total price including tax
 * @throws {Error} If tax rate is negative
 */
export function calculateTotal(
  items: CartItem[],
  taxRate: number
): number {
  // Implementation
}
```

**Python (Docstrings)**:
```python
def calculate_total(items: list[dict], tax_rate: float) -> float:
    """Calculate the total price including tax.
    
    Args:
        items: List of cart items with 'price' and 'quantity' keys
        tax_rate: Tax rate as decimal (e.g., 0.1 for 10%)
        
    Returns:
        Total price including tax
        
    Raises:
        ValueError: If tax rate is negative
        
    Example:
        >>> items = [{"price": 10, "quantity": 2}]
        >>> calculate_total(items, 0.1)
        22.0
    """
    # Implementation
```

### README Updates

Update README.md when:
- Adding new features
- Changing setup instructions
- Modifying API endpoints
- Adding dependencies

## 🔒 Security Practices

### Never Commit Secrets

**Prevent**:
- Add `.env` to `.gitignore`
- Use environment variables
- Use secret management services

**If You Accidentally Commit a Secret**:
1. Rotate the secret immediately
2. Use `git-filter-repo` or BFG to remove from history
3. Force push (coordinate with team)
4. Document the incident

### Dependency Security

**Check for Vulnerabilities**:
```bash
# TypeScript/JavaScript
npm audit

# Python
poetry audit  # Requires safety plugin
```

**Update Dependencies**:
- Review Renovate PRs
- Read release notes
- Test thoroughly
- Merge promptly

### Input Validation

Always validate user input:
```typescript
// ❌ Bad
function processOrder(orderId: string) {
  const query = `SELECT * FROM orders WHERE id = ${orderId}`;
  // SQL injection risk!
}

// ✅ Good
function processOrder(orderId: string) {
  if (!isValidUuid(orderId)) {
    throw new Error('Invalid order ID');
  }
  
  const query = 'SELECT * FROM orders WHERE id = $1';
  return db.query(query, [orderId]);
}
```

## 🚨 Troubleshooting

### Tests Failing Locally

```bash
# Clear caches
npm run clean
npm install

# Or for Python
poetry env remove python
poetry install
```

### Pre-commit Hooks Blocking

```bash
# Fix issues automatically
npm run lint:fix
npm run format:fix

# Or for Python
poetry run ruff check --fix
poetry run black .
poetry run isort .
```

### CI Pipeline Failing

1. Run the same commands locally:
```bash
npm run lint
npm run typecheck
npm run test
```

2. Check CI logs for specific errors

3. Verify Node/Python version matches CI

### Merge Conflicts

```bash
# Update your branch with main
git fetch origin
git rebase origin/main

# Resolve conflicts in your editor
# Then:
git add .
git rebase --continue
```

## 📞 Getting Help

- **Documentation**: Check `/docs` folder
- **Slack/Discord**: Ask in `#engineering` channel
- **Office Hours**: Tuesday/Thursday 2-3pm
- **On-Call**: Page via PagerDuty for urgent issues

## 📈 Metrics and Goals

We track:
- **Cycle Time**: PR open to merge (<2 days target)
- **Test Coverage**: >80% for new code
- **Build Success Rate**: >95%
- **MTTR**: Mean time to resolve (<4 hours for P0)

## 🎉 Recognition

Great contributors:
- Write clear specs
- Include comprehensive tests
- Document decisions
- Help others in reviews
- Improve tooling and processes

Thank you for contributing! 🙏
