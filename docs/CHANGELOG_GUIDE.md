# Changelog Management Guide

How to maintain a clear, useful changelog using conventional commits.

## Overview

A good changelog:
- Lists all notable changes
- Organized by version
- Written for users (not developers)
- Links to relevant PRs/issues
- Follows [Keep a Changelog](https://keepachangelog.com/)

## Format

We follow **Keep a Changelog** format:

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New features go here

### Changed
- Changes to existing functionality

### Deprecated
- Features that will be removed

### Removed
- Features that were removed

### Fixed
- Bug fixes

### Security
- Security fixes

## [1.2.0] - 2024-01-15

### Added
- User authentication with JWT ([#123](link))
- Password reset functionality ([#124](link))

### Changed
- Improved performance of database queries ([#125](link))
- Updated UI components to use new design system

### Fixed
- Memory leak in WebSocket connections ([#126](link))
- Race condition in cart checkout ([#127](link))

## [1.1.0] - 2023-12-01

...

[Unreleased]: https://github.com/user/repo/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/user/repo/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/user/repo/releases/tag/v1.1.0
```

## Sections

### Added
New features added to the project.

**Examples**:
```markdown
### Added
- User authentication with JWT tokens
- Dark mode toggle in settings
- Export data to CSV functionality
- Real-time notifications via WebSockets
```

### Changed
Changes to existing functionality.

**Examples**:
```markdown
### Changed
- Improved performance of search by 50%
- Updated design of user profile page
- Changed default timeout from 30s to 60s
- Refactored payment service for better maintainability
```

### Deprecated
Features that will be removed in future versions.

**Examples**:
```markdown
### Deprecated
- Old authentication API endpoints (use /api/v2/auth instead)
- Legacy payment provider integration
- `getUserById()` function (use `getUser()` instead)
```

### Removed
Features that were removed.

**Examples**:
```markdown
### Removed
- Support for Internet Explorer 11
- Deprecated v1 API endpoints
- Legacy authentication system
```

### Fixed
Bug fixes.

**Examples**:
```markdown
### Fixed
- Memory leak in long-running connections
- Race condition causing duplicate orders
- Incorrect tax calculation for international orders
- Login button not working on mobile Safari
```

### Security
Security improvements and fixes.

**Examples**:
```markdown
### Security
- Fixed SQL injection vulnerability in search
- Updated dependencies with known vulnerabilities
- Implemented rate limiting on login endpoint
- Added CSRF protection to all forms
```

## From Conventional Commits

### Manual Mapping

Map conventional commit types to changelog sections:

| Commit Type | Changelog Section |
|-------------|-------------------|
| feat | Added |
| fix | Fixed |
| perf | Changed |
| refactor | Changed |
| docs | (usually not in changelog) |
| style | (not in changelog) |
| test | (not in changelog) |
| chore | (not in changelog) |
| BREAKING CHANGE | Changed (with warning) |

### Automated Generation

Use tools to generate changelog from commits:

**standard-version** (npm):
```bash
npm install -D standard-version

# Generate changelog and bump version
npx standard-version

# Dry run
npx standard-version --dry-run

# First release
npx standard-version --first-release
```

**commitizen** + **cz-conventional-changelog**:
```bash
npm install -D commitizen cz-conventional-changelog

# Configure
echo '{ "path": "cz-conventional-changelog" }' > .czrc

# Interactive commit
npx cz
```

**conventional-changelog-cli**:
```bash
npm install -D conventional-changelog-cli

# Generate changelog
npx conventional-changelog -p angular -i CHANGELOG.md -s

# For first release
npx conventional-changelog -p angular -i CHANGELOG.md -s -r 0
```

## Best Practices

### 1. Write for Users, Not Developers

❌ **Bad**:
```markdown
- Refactored UserService to use dependency injection
- Changed internal API structure
- Updated test fixtures
```

✅ **Good**:
```markdown
- Improved app startup time by 30%
- Fixed login button not working on mobile
- Added ability to export your data
```

### 2. Be Specific

❌ **Bad**:
```markdown
- Bug fixes
- Performance improvements
- Various updates
```

✅ **Good**:
```markdown
- Fixed race condition causing duplicate charges
- Reduced page load time by 50% for large datasets
- Updated email templates to match new brand
```

### 3. Link to Issues/PRs

✅ **Good**:
```markdown
- Fixed memory leak in WebSocket connections ([#123](https://github.com/user/repo/pull/123))
- Added dark mode ([#456](https://github.com/user/repo/pull/456))
```

### 4. Group Related Changes

✅ **Good**:
```markdown
### Authentication System Overhaul
- Added JWT-based authentication
- Implemented password reset flow
- Added two-factor authentication
- Improved security of session management
```

### 5. Highlight Breaking Changes

✅ **Good**:
```markdown
### Changed
- **BREAKING**: Authentication API moved from `/auth` to `/api/v2/auth`
  
  **Migration**: Update your API calls:
  ```diff
  - fetch('/auth/login')
  + fetch('/api/v2/auth/login')
  ```
```

### 6. Include Migration Guides

✅ **Good**:
```markdown
### Changed
- **BREAKING**: Changed configuration format

  **Before**:
  ```json
  {
    "api": {
      "host": "localhost",
      "port": 3000
    }
  }
  ```

  **After**:
  ```json
  {
    "api": "http://localhost:3000"
  }
  ```
```

## Unreleased Section

Keep an `[Unreleased]` section at the top:

```markdown
## [Unreleased]

### Added
- New feature X (PR #123)

### Fixed
- Bug in feature Y (PR #124)
```

When releasing, move contents to versioned section:

```markdown
## [1.3.0] - 2024-02-01

### Added
- New feature X (PR #123)

### Fixed
- Bug in feature Y (PR #124)

## [1.2.0] - 2024-01-15
...
```

## Automation with GitHub Actions

### Auto-generate on Release

```yaml
# .github/workflows/release.yml
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Generate changelog
        id: changelog
        uses: mikepenz/release-changelog-builder-action@v4
        with:
          configuration: ".github/changelog-config.json"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

      - name: Create Release
        uses: softprops/action-gh-release@v1
        with:
          body: ${{ steps.changelog.outputs.changelog }}
```

### Auto-update CHANGELOG.md

```yaml
# .github/workflows/changelog.yml
name: Update Changelog

on:
  pull_request:
    types: [closed]
    branches:
      - main

jobs:
  changelog:
    if: github.event.pull_request.merged == true
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Update Changelog
        uses: stefanzweifel/changelog-updater-action@v1
        with:
          latest-version: ${{ github.event.pull_request.base.ref }}
          release-notes: ${{ github.event.pull_request.body }}

      - name: Commit changes
        uses: stefanzweifel/git-auto-commit-action@v4
        with:
          commit_message: "docs: update changelog"
          file_pattern: CHANGELOG.md
```

## Configuration for Changelog Builders

### .github/changelog-config.json

```json
{
  "categories": [
    {
      "title": "## 🎉 New Features",
      "labels": ["feature", "enhancement"]
    },
    {
      "title": "## 🐛 Bug Fixes",
      "labels": ["bug", "fix"]
    },
    {
      "title": "## 🔒 Security",
      "labels": ["security"]
    },
    {
      "title": "## 📝 Documentation",
      "labels": ["documentation", "docs"]
    },
    {
      "title": "## 🏗️ Infrastructure",
      "labels": ["infrastructure", "ci", "cd"]
    },
    {
      "title": "## 🧹 Maintenance",
      "labels": ["chore", "dependencies"]
    }
  ],
  "ignore_labels": [
    "ignore-for-release",
    "wont-fix"
  ],
  "sort": "ASC",
  "template": "#{{CHANGELOG}}",
  "pr_template": "- #{{TITLE}} ([#{{NUMBER}}]({{URL}})) by @{{AUTHOR}}",
  "empty_template": "No changes",
  "label_extractor": [
    {
      "pattern": "^(build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test)(\\(.*\\))?!?:",
      "target": "$1"
    }
  ]
}
```

## AI-Generated Changelog Entries

### Prompt for AI

```markdown
Generate a changelog entry from these commits:

Commits:
- feat(auth): add JWT authentication
- feat(auth): add password reset
- fix(cart): resolve race condition
- docs: update API documentation

Format:
- User-friendly descriptions
- Group related changes
- Follow Keep a Changelog format
- Include PR numbers
```

### AI Output

```markdown
### Added
- **Authentication**: Implemented JWT-based authentication system with secure token management
- **Password Reset**: Added password reset functionality with email verification

### Fixed
- **Shopping Cart**: Resolved race condition that could cause duplicate orders during rapid checkouts

### Documentation
- Updated API documentation with new authentication endpoints
```

## Version Bumping

### Semantic Versioning Rules

**MAJOR** (X.0.0):
- Breaking changes
- Removal of deprecated features
- Major architectural changes

```markdown
## [2.0.0] - 2024-03-01

### Changed
- **BREAKING**: Removed support for Node 14
- **BREAKING**: Changed authentication API structure
```

**MINOR** (1.X.0):
- New features
- New functionality
- Backward-compatible changes

```markdown
## [1.3.0] - 2024-02-01

### Added
- New payment provider integration
- Bulk export functionality
```

**PATCH** (1.2.X):
- Bug fixes
- Security patches
- Performance improvements (no API changes)

```markdown
## [1.2.3] - 2024-01-20

### Fixed
- Memory leak in WebSocket handler
- Incorrect tax calculation

### Security
- Updated dependencies with vulnerabilities
```

### Auto-bump with standard-version

```bash
# Automatically determine version bump
npx standard-version

# Force specific bump
npx standard-version --release-as major
npx standard-version --release-as minor
npx standard-version --release-as patch

# Pre-release
npx standard-version --prerelease alpha
npx standard-version --prerelease beta
```

## Changelog Templates

### Simple Template

```markdown
# Changelog

## [Unreleased]

## [1.0.0] - 2024-01-15
### Added
- Initial release
```

### Detailed Template

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- List new features here

### Changed
- List changes here

### Deprecated
- List deprecations here

### Removed
- List removals here

### Fixed
- List bug fixes here

### Security
- List security fixes here

## [1.0.0] - 2024-01-15

### Added
- Initial release with core features:
  - Feature 1
  - Feature 2
  - Feature 3

[Unreleased]: https://github.com/user/repo/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/user/repo/releases/tag/v1.0.0
```

## Review Checklist

Before releasing:

- [ ] All changes since last release are documented
- [ ] Changes are in correct sections (Added, Changed, etc.)
- [ ] Breaking changes are clearly marked
- [ ] Migration guides provided for breaking changes
- [ ] PR/issue links are included
- [ ] Version number follows semver
- [ ] Release date is correct
- [ ] Comparison links are updated
- [ ] No typos or unclear descriptions
- [ ] User-facing language (not technical jargon)

## Resources

- [Keep a Changelog](https://keepachangelog.com/)
- [Semantic Versioning](https://semver.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [standard-version](https://github.com/conventional-changelog/standard-version)
- [release-changelog-builder](https://github.com/marketplace/actions/release-changelog-builder)

## Summary

A good changelog:
- ✅ Is written for users
- ✅ Groups changes by type
- ✅ Links to relevant PRs/issues
- ✅ Highlights breaking changes
- ✅ Includes migration guides
- ✅ Follows consistent format
- ✅ Is easy to scan

Update the changelog with every PR, keep it current, make it useful.
