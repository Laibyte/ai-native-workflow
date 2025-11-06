# Template Comparison: Production vs Balanced

## Overview

This document compares the **production-ready template** with the **balanced template** for everyday use.

## Key Differences

| Feature | Production Template | Balanced Template |
|---------|-------------------|-------------------|
| **Setup Time** | 5-10 minutes | 2-3 minutes |
| **Dependencies** | 10+ dev packages | 5 dev packages |
| **Coverage Threshold** | 80% | 70% |
| **mypy Mode** | Strict | Relaxed |
| **Pre-commit Hooks** | 11 hooks | 6 hooks |
| **Documentation** | Extensive (6 docs) | Minimal (3 docs) |
| **CI/CD** | GitHub Actions | Not included |
| **Security Scanning** | Bandit + detect-secrets | Not included |
| **Task Runner** | Make + Poe | Make only |
| **Cursor Hooks** | Complex automation | Simple rules |

## What Was Removed

### ❌ Removed from Production Template

1. **Heavy tooling**
   - Bandit (security scanner)
   - detect-secrets (credential detection)
   - poethepoet (task runner)
   - pytest-xdist (parallel testing)
   - pytest-asyncio (unless needed)

2. **Strict configurations**
   - mypy strict mode
   - Extensive Ruff rules (50+ rules → 9 rules)
   - Conventional commits enforcement
   - Complex pytest config

3. **Documentation overhead**
   - ARCHITECTURE.md
   - TECHNICAL.md
   - MEMORY_BANK.md
   - PROJECT_SPEC.md
   - Extensive README sections

4. **CI/CD complexity**
   - GitHub Actions workflows
   - Dependabot configuration
   - PR templates

5. **Cursor automation**
   - Complex hook scripts
   - Multiple rule files
   - Custom commands

## What Was Kept

### ✅ Kept from Production Template

1. **Core tooling**
   - Poetry (dependency management)
   - Ruff (fast linting/formatting)
   - pytest + coverage
   - mypy (type checking)
   - pre-commit hooks

2. **Essential configs**
   - VSCode/Cursor settings
   - Basic Ruff rules
   - Reasonable mypy settings
   - Simple pytest config

3. **Project structure**
   - src/ layout
   - tests/ directory
   - Clear separation

4. **Developer experience**
   - Make commands
   - Format on save
   - Auto-fix on save
   - Test discovery

## When to Use Each Template

### Use Production Template When:
- Building production applications
- Working in a team
- Need strict quality gates
- Require security scanning
- Want comprehensive CI/CD
- Need detailed documentation

### Use Balanced Template When:
- Starting side projects
- Experimenting with ideas
- Learning new concepts
- Building prototypes
- Working solo
- Want quick setup

## Migration Path

### From Balanced → Production

Add features as needed:

```bash
# Add security scanning
poetry add --group dev bandit detect-secrets

# Add async testing
poetry add --group dev pytest-asyncio

# Add parallel testing
poetry add --group dev pytest-xdist

# Enable strict mypy
# In pyproject.toml: strict = true

# Add more Ruff rules
# In pyproject.toml: expand select list

# Add CI/CD
# Copy .github/workflows/ from production template
```

### From Production → Balanced

Simplify by removing:

```bash
# Remove heavy dependencies
poetry remove bandit detect-secrets poethepoet pytest-xdist

# Simplify configs
# Reduce Ruff rules in pyproject.toml
# Disable mypy strict mode
# Remove complex pre-commit hooks

# Clean up documentation
# Keep only README.md and CHANGELOG.md
```

## Performance Comparison

### Setup Time
- **Production**: ~10 minutes (more dependencies, hooks, checks)
- **Balanced**: ~3 minutes (fewer dependencies, simpler setup)

### Pre-commit Speed
- **Production**: 10-15 seconds (11 hooks including security scans)
- **Balanced**: 3-5 seconds (6 essential hooks)

### Test Execution
- **Production**: Parallel with xdist, strict coverage
- **Balanced**: Sequential, relaxed coverage

## Recommendations

### For Beginners
Start with **Balanced Template**:
- Less overwhelming
- Faster feedback loop
- Learn core concepts
- Scale up later

### For Experienced Developers
Choose based on project:
- **Side project**: Balanced
- **Work project**: Production
- **Open source**: Production
- **Experiment**: Balanced

### For Teams
Use **Production Template**:
- Consistent quality
- Security requirements
- Documentation needs
- CI/CD integration

## Conclusion

Both templates have their place:

- **Production Template**: Comprehensive, strict, team-ready
- **Balanced Template**: Fast, flexible, experiment-friendly

Choose based on your needs, and remember: you can always scale up from Balanced to Production as your project grows!
