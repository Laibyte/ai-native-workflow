# GitHub Copilot Configuration

This file configures GitHub Copilot behavior for this project.

## Shared Rules

Core AI agent rules are maintained in `.cursor/rules/shared-rules.mdc`.

Key principles:
- Expert-level Principal Software Engineer persona
- Concise, technical, direct communication
- Production-grade code with mandatory self-audit
- Complete implementations (no placeholders/TODOs)
- Environment variables for secrets (never hardcode)
- Poetry for Python package management (never pip)
- Conventional Commits format for all commit messages

## Python Standards

### Type Hints
- All functions MUST have type hints for parameters and return values
- Use modern syntax: `list[str]` instead of `List[str]`
- Strict mypy compliance required

### Code Style
- PEP 8 compliance enforced by Ruff
- F-strings for all string formatting
- 100 character line length
- Google-style docstrings

### Testing
- Pytest for all tests
- Minimum 80% code coverage required
- Use fixtures for shared test data
- Parametrize for multiple test cases

### Quality Checks

Before committing, run:
```bash
poetry run poe format        # Format code
poetry run poe lint-fix      # Fix linting issues
poetry run poe type-check    # Check types
poetry run poe test          # Run tests
```

Or run all checks:
```bash
poetry run poe all
# or
make all
```

### Pre-commit Hooks

Pre-commit hooks automatically run:
- Ruff (linting and formatting)
- mypy (type checking)
- Bandit (security scanning)
- detect-secrets (credential detection)
- Conventional commit validation

## Project Structure

```
src/           # All source code
tests/         # All tests (mirror src structure)
docs/          # Project documentation
.cursor/       # Cursor IDE configuration
.github/       # GitHub configuration and workflows
.vscode/       # VSCode/Cursor settings
```

## Documentation Requirements

- All modules MUST have module docstrings
- All classes MUST have class docstrings
- All public functions MUST have Google-style docstrings with Args, Returns, Raises, and Examples

## Security

- Never commit secrets or API keys
- Use environment variables for configuration
- Validate all user inputs
- Keep dependencies updated
- Run `poetry run poe security` for security checks

## Reference

For complete rules and guidelines, see:
- `.cursor/rules/shared-rules.mdc` - Core AI agent rules
- `.cursor/rules/python-standard.mdc` - Project-specific standards
- `pyproject.toml` - Tool configurations (Ruff, mypy, pytest, etc.)
- `README.md` - Setup and usage instructions
