# GitHub Actions Workflows

This directory contains CI/CD workflows for the project.

## Active Workflows

### `python-ci.yml` - Python Continuous Integration

**Triggers**: Push to `main`/`develop`, Pull Requests

**Jobs**:
- **quality**: Runs code quality checks on Python 3.11 and 3.12
  - Ruff linting and formatting checks
  - mypy type checking
  - Bandit security scanning
  - pytest with coverage reporting
  - Package build verification
  - Uploads coverage to Codecov (if token configured)

- **pre-commit**: Validates all pre-commit hooks pass
  - Ensures commit-time checks work in CI

- **security**: Security and dependency audits
  - detect-secrets credential scanning
  - Checks for outdated dependencies

**Status Badge**:
```markdown
[![Python CI](https://github.com/YOUR_USERNAME/YOUR_REPO/actions/workflows/python-ci.yml/badge.svg)](https://github.com/YOUR_USERNAME/YOUR_REPO/actions/workflows/python-ci.yml)
```

### `dependabot.yml` - Automated Dependency Updates

**Purpose**: Keeps dependencies up to date via Dependabot PRs

**Configuration**:
- Python dependencies: Weekly updates on Mondays
- GitHub Actions: Weekly updates on Mondays
- Maximum 5 open PRs at a time
- Auto-labels with `dependencies` and package ecosystem

**Setup**: Update `reviewers` field with your GitHub username.

## Workflow Configuration

### Required Secrets

For full functionality, configure these secrets in repository settings:

- `CODECOV_TOKEN`: (Optional) For coverage reporting to Codecov
  - Get token from https://codecov.io after adding your repository
  - Without this, coverage upload will be skipped but CI will pass

### Branch Protection

Recommended branch protection rules for `main`:

1. Require pull request reviews (1 approver)
2. Require status checks to pass:
   - `Code Quality (Python 3.12)`
   - `Pre-commit Hooks`
   - `Security Audit`
3. Require branches to be up to date
4. Require conversation resolution before merging
5. Do not allow force pushes
6. Do not allow deletions

### Caching Strategy

Workflows use GitHub Actions cache to speed up runs:
- Poetry virtual environments cached by `poetry.lock` hash
- Cache key includes OS and Python version
- Typical speedup: 2-3x faster subsequent runs

## Customization

### Python Versions

To test additional Python versions, update the matrix in `python-ci.yml`:

```yaml
strategy:
  matrix:
    python-version: ["3.11", "3.12", "3.13"]
```

### Coverage Thresholds

Coverage requirements are set in `pyproject.toml`:

```toml
[tool.pytest.ini_options]
addopts = [
    "--cov-fail-under=80",
]
```

### Adding More Checks

To add additional CI checks, create new jobs in `python-ci.yml`:

```yaml
custom-check:
  name: My Custom Check
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    # Add your steps here
```

## Local Testing

Test workflows locally before pushing:

```bash
# Run the same checks CI runs
poetry run poe all

# Or individually
poetry run poe lint
poetry run poe format
poetry run poe type-check
poetry run poe test
poetry run poe security

# Run pre-commit hooks
poetry run pre-commit run --all-files
```

## Troubleshooting

### Workflow Fails on First Run

First-time runs may fail due to:
- Missing secrets (Codecov token) - Set `fail_ci_if_error: false` or add token
- Pre-commit hooks not initialized - They install automatically in CI

### Cache Issues

Clear caches if builds behave unexpectedly:
1. Go to Actions → Caches
2. Delete caches for your branch
3. Re-run workflow

### Poetry Lock File Conflicts

If `poetry.lock` changes cause CI failures:
```bash
# Ensure lock file is up to date
poetry lock --no-update
git add poetry.lock
git commit -m "chore: update poetry lock file"
```

## Best Practices

1. **Always run checks locally** before pushing
2. **Keep dependencies updated** via Dependabot PRs
3. **Monitor workflow run times** - optimize if >5 minutes
4. **Use status badges** in README to show CI status
5. **Review and merge Dependabot PRs regularly**
6. **Don't skip pre-commit hooks** with `--no-verify`

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Poetry in CI/CD](https://python-poetry.org/docs/ci/)
- [Pre-commit CI](https://pre-commit.ci/)
- [Codecov Documentation](https://docs.codecov.com/)

