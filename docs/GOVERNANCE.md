# Governance Guide

Repository governance policies and procedures for AI-native development.

## Overview

Governance ensures:
- Code quality and consistency
- Security and compliance
- Clear ownership and accountability
- Efficient collaboration
- Risk management

## Repository Structure

### Branch Strategy

#### Main Branches

**`main`** (production):
- Always deployable
- Protected branch
- Requires PR approval
- All checks must pass
- No direct commits

**`develop`** (integration):
- Integration branch for features
- Protected branch
- Requires PR approval
- All checks must pass

#### Supporting Branches

**Feature branches**: `feat/feature-name`
- Created from `develop`
- Merged back to `develop`
- Deleted after merge

**Bug fix branches**: `fix/bug-description`
- Created from `develop` or `main` (for hotfixes)
- Merged back to source branch

**Release branches**: `release/v1.2.3`
- Created from `develop`
- Merged to `main` and `develop`
- Tagged with version

**Hotfix branches**: `hotfix/critical-bug`
- Created from `main`
- Merged to `main` and `develop`
- Tagged with patch version

### Branch Naming Conventions

```
Type/Description
├── feat/user-authentication
├── fix/memory-leak-cache
├── docs/update-api-guide
├── refactor/extract-user-service
├── test/add-integration-tests
├── chore/upgrade-dependencies
├── hotfix/critical-security-fix
└── release/v1.2.0
```

## Branch Protection

### Main Branch Protection

**Required**:
- [ ] Require pull request before merging
  - [ ] Require approvals: 2
  - [ ] Dismiss stale approvals when new commits are pushed
  - [ ] Require review from Code Owners
- [ ] Require status checks to pass
  - [ ] Require branches to be up to date before merging
  - [ ] Required checks:
    - Lint
    - Type check
    - Tests
    - Build
    - Security scan
- [ ] Require signed commits
- [ ] Require linear history (squash or rebase)
- [ ] Include administrators (enforce for everyone)
- [ ] Restrict who can push to matching branches
- [ ] Allow force pushes: No
- [ ] Allow deletions: No

**GitHub Settings**:
```yaml
Settings → Branches → Add branch protection rule

Branch name pattern: main

Rules:
  ✅ Require a pull request before merging
    - Required approvals: 2
    - ✅ Dismiss stale pull request approvals when new commits are pushed
    - ✅ Require review from Code Owners
    - ✅ Restrict who can dismiss pull request reviews
    
  ✅ Require status checks to pass before merging
    - ✅ Require branches to be up to date before merging
    - Status checks:
      - ci/lint
      - ci/typecheck
      - ci/test
      - ci/build
      - security/scan
  
  ✅ Require conversation resolution before merging
  ✅ Require signed commits
  ✅ Require linear history
  ✅ Include administrators
  
  ❌ Allow force pushes
  ❌ Allow deletions
```

### Develop Branch Protection

Same as `main` but:
- Required approvals: 1 (instead of 2)
- Can allow force pushes for maintainers (optional)

### Release Branch Protection

- Require pull request
- Require 1 approval
- Require status checks
- No direct commits
- Auto-delete after merge

## CODEOWNERS

Define who owns which parts of the codebase.

### File: `.github/CODEOWNERS`

```
# Global owners
* @org/core-team

# Frontend
/src/frontend/ @org/frontend-team
/packages/ui/ @org/frontend-team
*.tsx @org/frontend-team
*.css @org/frontend-team

# Backend
/src/backend/ @org/backend-team
/src/api/ @org/backend-team
/src/services/ @org/backend-team

# Infrastructure
/infra/ @org/devops-team
/terraform/ @org/devops-team
/.github/workflows/ @org/devops-team
Dockerfile @org/devops-team

# Database
/migrations/ @org/database-team
/prisma/ @org/database-team

# Security
/src/auth/ @org/security-team
/src/middleware/auth.ts @org/security-team
SECURITY.md @org/security-team

# Documentation
/docs/ @org/docs-team
*.md @org/docs-team
README.md @org/core-team

# Configuration
package.json @org/core-team
tsconfig.json @org/core-team
.eslintrc.json @org/core-team

# CI/CD
/.github/workflows/ @org/devops-team

# Tests
/__tests__/ @org/qa-team
*.test.ts @org/qa-team
```

### CODEOWNERS Syntax

```
# Pattern    Owner(s)
*.js         @org/js-team
/build/      @org/build-team
docs/*       @org/docs-team @user1
```

**Patterns**:
- `*`: Matches any file
- `/path/`: Matches directory
- `*.ext`: Matches file extension
- `path/*.ext`: Matches files in path
- `**/dir/`: Matches dir anywhere

### Ownership Verification

```bash
# Check who owns a file
gh api repos/:owner/:repo/contents/:path \
  --jq '.owner'

# List all owners
cat .github/CODEOWNERS | grep -v '^#' | grep -v '^$'
```

## Access Control

### Repository Permissions

**Admin**:
- Full access
- Manage settings
- Manage teams
- Delete repository
- Members: Core team leads

**Maintain**:
- Manage issues and PRs
- Manage releases
- Manage some settings
- Members: Senior engineers

**Write**:
- Push to repository
- Merge PRs
- Manage issues
- Members: All engineers

**Triage**:
- Manage issues and PRs
- Cannot push code
- Members: Support team

**Read**:
- View and clone repository
- Open issues and PRs
- Members: External contributors

### Team Structure

```
Organization
├── core-team (Admin)
│   ├── @tech-lead
│   └── @engineering-manager
├── backend-team (Write)
│   ├── @backend-engineer-1
│   └── @backend-engineer-2
├── frontend-team (Write)
│   ├── @frontend-engineer-1
│   └── @frontend-engineer-2
├── devops-team (Maintain)
│   ├── @devops-engineer-1
│   └── @devops-engineer-2
├── qa-team (Triage)
│   └── @qa-engineer
└── external (Read)
    └── @contractor
```

## Pull Request Policy

### PR Requirements

- [ ] Descriptive title (conventional commit format)
- [ ] Complete PR description (use template)
- [ ] Linked to issue (Linear, Jira)
- [ ] All CI checks passing
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No merge conflicts
- [ ] Approved by required reviewers
- [ ] All conversations resolved

### Review Requirements

**Small PRs** (<50 lines):
- 1 approval required
- Any team member can approve
- Can be fast-tracked

**Medium PRs** (50-200 lines):
- 1 approval required
- Reviewer from relevant team
- Standard review time: 24 hours

**Large PRs** (200-500 lines):
- 2 approvals required
- One from code owner
- Consider splitting if possible

**XL PRs** (>500 lines):
- 2+ approvals required
- Architecture review recommended
- Strong preference to split

### Review Timeline

| PR Size | Target Review Time | Max Wait Time |
|---------|-------------------|---------------|
| Small | 4 hours | 1 day |
| Medium | 1 day | 2 days |
| Large | 2 days | 3 days |
| XL | 3 days | 1 week |

### Auto-Merge Conditions

**Allowed for**:
- Dependency updates (Renovate/Dependabot)
- Documentation fixes
- Test additions
- Linting fixes

**Requirements**:
- All checks pass
- Required approvals
- No conversations
- Author has write access

**Not allowed for**:
- Breaking changes
- Security changes
- Infrastructure changes
- Database migrations

## Release Process

### Version Numbering

Follow [Semantic Versioning](https://semver.org/):

```
MAJOR.MINOR.PATCH

- MAJOR: Breaking changes
- MINOR: New features (backward compatible)
- PATCH: Bug fixes (backward compatible)
```

**Examples**:
- `1.0.0` → `1.0.1`: Bug fix
- `1.0.1` → `1.1.0`: New feature
- `1.1.0` → `2.0.0`: Breaking change

### Pre-release Versions

```
1.0.0-alpha.1  # Alpha release
1.0.0-beta.2   # Beta release
1.0.0-rc.3     # Release candidate
```

### Release Workflow

1. **Create release branch**
   ```bash
   git checkout develop
   git pull
   git checkout -b release/v1.2.0
   ```

2. **Update version**
   ```bash
   npm version 1.2.0
   # or
   poetry version 1.2.0
   ```

3. **Update CHANGELOG**
   ```markdown
   ## [1.2.0] - 2024-01-15
   
   ### Added
   - New feature X
   
   ### Changed
   - Improved performance of Y
   
   ### Fixed
   - Bug in Z
   ```

4. **Create release PR**
   ```bash
   git push origin release/v1.2.0
   # Create PR: release/v1.2.0 → main
   ```

5. **Review and approve**
   - QA testing
   - Stakeholder approval
   - Final review

6. **Merge to main**
   ```bash
   # Merge PR to main
   # Tag release
   git tag v1.2.0
   git push origin v1.2.0
   ```

7. **Backmerge to develop**
   ```bash
   git checkout develop
   git merge main
   git push origin develop
   ```

8. **Deploy**
   - Automated deployment via CI/CD
   - Monitor for issues
   - Announce release

### Release Notes

Template:

```markdown
# Release v1.2.0

## 🎉 Highlights

- Feature X: [Brief description]
- Performance improvement: [Metric]

## ✨ New Features

- **Feature 1** ([#123](link)): Description
- **Feature 2** ([#456](link)): Description

## 🐛 Bug Fixes

- **Bug 1** ([#789](link)): Description
- **Bug 2** ([#012](link)): Description

## 📝 Documentation

- Updated API docs
- Added migration guide

## ⚠️ Breaking Changes

**Action required**: [What users need to do]

```diff
- Old API
+ New API
```

## 📦 Dependencies

- Updated dependency X to v2.0
- Removed deprecated dependency Y

## 🙏 Contributors

Thanks to @user1, @user2, @user3

Full Changelog: v1.1.0...v1.2.0
```

## Issue Management

### Issue Labels

**Type**:
- `bug`: Something isn't working
- `feature`: New feature request
- `enhancement`: Improve existing feature
- `docs`: Documentation
- `question`: Further information requested
- `tech-debt`: Technical debt

**Priority**:
- `p0-critical`: Immediate attention required
- `p1-high`: Important, address soon
- `p2-medium`: Normal priority
- `p3-low`: Nice to have

**Status**:
- `triage`: Needs review
- `ready`: Ready for work
- `in-progress`: Being worked on
- `blocked`: Cannot proceed
- `needs-info`: More information needed

**Scope**:
- `frontend`: Frontend code
- `backend`: Backend code
- `infra`: Infrastructure
- `security`: Security related

### Issue Templates

**Bug Report**: `.github/ISSUE_TEMPLATE/bug_report.md`

**Feature Request**: `.github/ISSUE_TEMPLATE/feature_request.md`

**Documentation**: `.github/ISSUE_TEMPLATE/documentation.md`

### Triaging Issues

**Weekly triage meeting**:
1. Review new issues (label: `triage`)
2. Assign priority
3. Assign owner
4. Add to milestone/project
5. Remove `triage` label

**SLA**:
- P0: Response within 1 hour
- P1: Response within 24 hours
- P2: Response within 1 week
- P3: Response when possible

## Compliance

### Audit Trail

**Git History**:
- All changes tracked
- Commit messages explain why
- Signed commits verify author

**PR History**:
- Review comments preserved
- Approval trail visible
- Discussion documented

**Issue History**:
- Status changes logged
- Assignments tracked
- Comments preserved

### Retention Policies

**Code**:
- Keep indefinitely
- Archive old branches after 6 months

**Issues/PRs**:
- Keep indefinitely
- Never delete

**Releases**:
- Keep all releases
- Old releases can be deprecated but not deleted

**Logs**:
- CI/CD logs: 90 days
- Application logs: 1 year
- Security logs: 7 years

## Metrics and Reporting

### Key Metrics

**Development**:
- Cycle time (issue → deploy)
- Lead time (commit → production)
- Deployment frequency
- Change failure rate
- Mean time to recovery (MTTR)

**Quality**:
- Test coverage
- Bug escape rate
- Technical debt ratio
- Code review time

**Collaboration**:
- PR approval time
- Number of reviewers
- Review participation rate

### Dashboard

Track on dashboard:
- Open issues (by priority)
- Open PRs (by age)
- CI/CD success rate
- Deployment status
- Test coverage trend
- Dependency health

## Enforcement

### Automated Enforcement

**CI/CD**:
- Linting enforced
- Tests required
- Coverage threshold
- Security scanning

**Git Hooks**:
- Commit message format
- No secrets committed
- Pre-commit checks
- Pre-push validation

**Bots**:
- Auto-assign reviewers (CODEOWNERS)
- Auto-label PRs
- Auto-close stale issues
- Auto-merge approved PRs

### Manual Enforcement

**Code Review**:
- Verify adherence to standards
- Check test coverage
- Validate security practices
- Ensure documentation

**Retrospectives**:
- Review governance effectiveness
- Identify improvements
- Update policies as needed

## Exceptions

### Emergency Hotfixes

For P0 incidents:
1. Create hotfix branch from `main`
2. Bypass PR approval (with notification)
3. Deploy immediately
4. Create follow-up PR with review
5. Document in post-mortem

**Process**:
```bash
# Create hotfix
git checkout main
git checkout -b hotfix/critical-bug
# Fix and commit
git commit -m "hotfix: critical security fix"
git push origin hotfix/critical-bug

# Deploy (skip review)
# Document: Filed as #XYZ for post-review
```

### One-Time Exceptions

Request via:
1. Create issue explaining need
2. Get approval from tech lead
3. Document exception and rationale
4. Set expiration date
5. Create task to remove exception

## Resources

- [GitHub Branch Protection](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [CODEOWNERS Syntax](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
- [Semantic Versioning](https://semver.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)

## Summary

Good governance:
- ✅ Protects production code
- ✅ Ensures quality standards
- ✅ Provides clear ownership
- ✅ Enables efficient collaboration
- ✅ Maintains compliance
- ✅ Allows for emergency exceptions

Review and update governance policies quarterly.
