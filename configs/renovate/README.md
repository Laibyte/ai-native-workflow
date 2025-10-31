# Renovate Configuration

Automated dependency updates with Renovate.

## Overview

This Renovate configuration:
- ✅ Groups updates intelligently (patch, minor, major)
- ✅ Auto-merges safe updates (patch/minor with tests passing)
- ✅ Prioritizes security updates
- ✅ Respects stability periods (3 days for npm)
- ✅ Handles npm and poetry
- ✅ Updates GitHub Actions
- ✅ Creates manageable PRs

## Setup

### 1. Install Renovate

**GitHub App** (recommended):
1. Go to [github.com/apps/renovate](https://github.com/apps/renovate)
2. Install on your organization/repository
3. Configure repository access

**Self-hosted**:
```bash
npm install -g renovate
renovate --platform github --token $GITHUB_TOKEN
```

### 2. Add Configuration

Copy `renovate.json` to repository root:

```bash
cp configs/renovate/renovate.json .github/renovate.json
# or
cp configs/renovate/renovate.json renovate.json
```

### 3. Configure GitHub

**.github/renovate.json**:
```json
{
  "extends": [
    "config:recommended"
  ]
}
```

Or use the full configuration provided.

## Configuration Explained

### Update Grouping

**Patch Updates**: Grouped together, auto-merged
```json
{
  "matchUpdateTypes": ["patch"],
  "groupName": "all patch dependencies",
  "automerge": true
}
```

**Minor Updates**: Grouped together, requires review
```json
{
  "matchUpdateTypes": ["minor"],
  "groupName": "all minor dependencies",
  "automerge": false
}
```

**Major Updates**: Individual PRs, high priority, requires review
```json
{
  "matchUpdateTypes": ["major"],
  "labels": ["dependencies", "major-update"],
  "automerge": false,
  "prPriority": 10
}
```

### Auto-Merge Rules

Auto-merge enabled for:
- Patch and minor updates for stable packages (version ≥1.0.0)
- Linting and formatting tools
- GitHub Actions
- Dev dependencies (patch/minor)

Auto-merge disabled for:
- Major updates
- Core framework updates (React, TypeScript, etc.)
- Testing frameworks
- Any breaking changes

**Conditions for auto-merge**:
1. All CI checks pass
2. Package has been released for 3+ days (npm)
3. Not a pre-release version

### Security Updates

Security vulnerabilities get:
- Highest priority (100)
- Immediate creation (no schedule)
- `security` label
- Assigned to security team

### Stability Period

**npm**: 3 days minimum release age before updates

This prevents adopting releases with critical bugs that get patched immediately.

### PR Management

**Limits**:
- Max 10 concurrent PRs
- No hourly limit
- Immediate creation (no batching delay)

**Rebase**:
- Automatically rebase when behind base branch
- Keeps PRs up to date

## Package Rules

### TypeScript

```json
{
  "matchPackageNames": ["typescript"],
  "automerge": false,
  "labels": ["dependencies", "typescript"],
  "prPriority": 20
}
```

TypeScript updates require review due to potential breaking changes.

### React

```json
{
  "matchPackageNames": ["react", "react-dom"],
  "groupName": "React",
  "automerge": false
}
```

React updates grouped together, require review.

### Testing Frameworks

```json
{
  "matchPackagePatterns": ["^vitest", "^jest", "^pytest"],
  "groupName": "Testing frameworks",
  "automerge": false
}
```

Testing framework updates require review and testing.

### Linting and Formatting

```json
{
  "matchPackagePatterns": ["^eslint", "^prettier", "^ruff"],
  "groupName": "Linting and formatting",
  "automerge": true
}
```

Linting/formatting updates are safe to auto-merge.

### GitHub Actions

```json
{
  "matchManagers": ["github-actions"],
  "automerge": true,
  "pinDigests": true
}
```

GitHub Actions updated and pinned to SHA for security.

## Customization

### Ignore Specific Dependencies

```json
{
  "ignoreDeps": [
    "package-name",
    "@scope/package-name"
  ]
}
```

### Change Schedule

```json
{
  "schedule": ["before 9am on Monday"]
}
```

Options:
- `["before 9am every weekday"]`
- `["after 10pm every weekday"]`
- `["every weekend"]`
- `["on the first day of the month"]`

### Adjust Auto-Merge

**More aggressive** (auto-merge minor updates):
```json
{
  "matchUpdateTypes": ["minor", "patch"],
  "automerge": true
}
```

**More conservative** (no auto-merge):
```json
{
  "automerge": false
}
```

### Add Custom Package Rules

```json
{
  "packageRules": [
    {
      "matchPackageNames": ["critical-package"],
      "automerge": false,
      "prPriority": 100,
      "assignees": ["@critical-maintainer"]
    }
  ]
}
```

## Workflow

### 1. Renovate Creates PR

Renovate checks for updates on schedule (Monday mornings) and creates PRs.

**PR Includes**:
- Update description
- Release notes
- Changelog links
- Compatibility notes
- Test results

### 2. CI Runs

GitHub Actions runs:
- Linting
- Type checking
- Tests
- Build

### 3. Auto-Merge or Review

**Auto-merge** (if conditions met):
- PR auto-merged after CI passes
- Notification sent

**Review** (if auto-merge disabled):
- Team reviews PR
- Approves or requests changes
- Merges manually

### 4. Monitor

After merge:
- Monitor error rates
- Check performance metrics
- Roll back if issues detected

## Dashboard

Renovate creates a "Dependency Dashboard" issue:

**Shows**:
- Pending updates
- Open PRs
- Rate-limited PRs
- Ignored updates
- Configuration errors

**Actions**:
- Trigger updates manually
- Ignore specific versions
- Rebase PRs

## Troubleshooting

### PRs Not Created

**Check**:
1. Renovate is installed and has repo access
2. Configuration is valid JSON
3. No rate limits hit
4. Schedule matches current time

**Debug**:
```bash
LOG_LEVEL=debug renovate
```

### Auto-Merge Not Working

**Check**:
1. Branch protection allows auto-merge
2. CI checks are required and passing
3. `platformAutomerge` is true
4. Package meets auto-merge rules

**GitHub Settings**:
- Settings → Branches → Branch protection rules
- Enable "Allow auto-merge"
- Require status checks

### Too Many PRs

**Reduce**:
```json
{
  "prConcurrentLimit": 5,
  "prHourlyLimit": 2
}
```

**Group more**:
```json
{
  "matchUpdateTypes": ["minor", "patch"],
  "groupName": "all non-major dependencies"
}
```

### Security Alerts Not Working

**Check**:
```json
{
  "vulnerabilityAlerts": {
    "enabled": true
  }
}
```

Enable Dependabot alerts in GitHub:
- Settings → Security & analysis → Dependabot alerts

## Best Practices

1. **Start conservative**: Disable auto-merge initially, enable gradually
2. **Monitor closely**: Watch first few auto-merges carefully
3. **Test thoroughly**: Ensure CI is comprehensive
4. **Review major updates**: Always review major version bumps
5. **Keep config updated**: Review Renovate config quarterly
6. **Use dependency dashboard**: Check it weekly
7. **Act on security updates**: Merge security PRs immediately

## Integration with AI Agents

### Background Agent Task

AI agent can:
1. Review Renovate PRs
2. Read release notes and changelogs
3. Assess breaking changes
4. Run additional tests if needed
5. Approve or flag for human review

### Prompt for Agent

```markdown
Review Renovate PR #123:
1. Read release notes
2. Check for breaking changes
3. Verify tests pass
4. Assess risk (low/medium/high)
5. Approve if low risk, flag if medium/high
```

## Resources

- [Renovate Docs](https://docs.renovatebot.com/)
- [Configuration Options](https://docs.renovatebot.com/configuration-options/)
- [Package Rules](https://docs.renovatebot.com/configuration-options/#packagerules)
- [Presets](https://docs.renovatebot.com/presets/)

## Summary

Renovate keeps dependencies up to date with:
- ✅ Intelligent grouping
- ✅ Safe auto-merging
- ✅ Security prioritization
- ✅ Minimal noise
- ✅ Easy customization

Set it up once, keep dependencies fresh forever.
