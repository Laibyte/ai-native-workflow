# My Project

AI-native Python project with comprehensive tooling and quality checks.

## Features

- 🚀 Modern Python 3.11+ with Poetry
- 🧪 Testing with pytest and coverage
- 🔍 Linting and formatting with Ruff
- 📝 Type checking with mypy
- 🔒 Security scanning with Bandit
- 🪝 Pre-commit hooks for quality enforcement
- 📦 Task runner with poethepoet
- 🎯 Conventional commits enforced

## Quick Start

### Prerequisites

- Python 3.11+
- [Poetry](https://python-poetry.org/docs/#installation)
- Git
- VSCode or Cursor IDE (recommended)

### Installation

```bash
# Clone the repository
git clone <your-repo-url>
cd my-project

# One-command setup (recommended)
bash .cursor/hooks/setup.sh

# This will:
# - Install Poetry dependencies
# - Install pre-commit hooks
# - Setup detect-secrets baseline
# - Run initial quality checks
# - Install VSCode/Cursor extensions (if IDE available)
```

### Alternative Setup

```bash
# Manual step-by-step setup
poetry install                          # Install dependencies
poetry run pre-commit install          # Install git hooks
poetry run pre-commit install --hook-type commit-msg
poetry run detect-secrets scan > .secrets.baseline

# Install recommended IDE extensions
bash .cursor/hooks/setup-extensions.sh

# Run initial checks
poetry run pre-commit run --all-files
```

## Development

### Using Make Commands
```bash
make test          # Run tests
make test-cov      # Run tests with coverage
make lint          # Run linting
make lint-fix      # Run linting with auto-fix
make format        # Format code
make type-check    # Run type checking
make security      # Run security checks
make all           # Run all checks
make clean         # Clean up generated files
```

### Using Poe Commands (npm-style)
```bash
poetry run poe test          # Run tests
poetry run poe test-cov      # Run tests with coverage
poetry run poe lint          # Run linting
poetry run poe lint-fix      # Run linting with auto-fix
poetry run poe format        # Format code
poetry run poe type-check    # Run type checking
poetry run poe security      # Run security checks
poetry run poe all           # Run all checks
poetry run poe clean         # Clean up generated files
```

## Project Structure
```
my-project/
├── src/                     # Source code
│   ├── __init__.py
│   └── main.py         
├── tests/                   # Tests
│   ├── __init__.py
│   └── test_main.py
├── .vscode/                 # VS Code settings
├── pyproject.toml           # Project configuration
├── .pre-commit-config.yaml  # Pre-commit hooks
├── .cursorrules             # Cursor AI rules
├── Makefile                 # Make commands
└── README.md                # This file
```

## Code Quality Tools

- Ruff: Fast linting and formatting (replaces black, isort, flake8, etc.)
- mypy: Static type checker with strict mode enabled
- pytest: Testing framework with coverage reporting
- Bandit: Security vulnerability scanner
- pre-commit: Git hooks for automated quality checks

## Git Workflow

### Commit Messages

This project enforces [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/):
```bash 
git commit -m "feat: add new feature"
git commit -m "fix: resolve bug in authentication"
git commit -m "docs: update README"
git commit -m "test: add tests for user service"
```

### Pre-commit Hooks

Hooks automatically run on:
- On commit: Fast tests, linting, formatting, type checking
- On push: Full test suite
- On commit-msg: Conventional commit validation

To manually run all hooks:
```bash
make pre-commit
# or
poetry run pre-commit run --all-files
```

## IDE Setup

### Automatic Extension Installation

The setup script will attempt to install recommended extensions automatically. If you skipped this or want to install them manually:

```bash
# Auto-install extensions
bash .cursor/hooks/setup-extensions.sh
```

### Recommended Extensions

The project includes IDE configuration for:
- ✅ Auto-format on save with Ruff
- ✅ Auto-fix linting issues on save
- ✅ Type checking with mypy
- ✅ Python test discovery
- ✅ Inline error display with Error Lens
- ✅ Better code comments highlighting
- ✅ Spell checking
- ✅ GitLens integration

### Manual Extension Installation

If automatic installation doesn't work:

1. Open Command Palette (`Cmd/Ctrl + Shift + P`)
2. Type "Extensions: Show Recommended Extensions"
3. Click "Install All"

Or install individually:
```bash
code --install-extension charliermarsh.ruff
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.mypy-type-checker
code --install-extension tamasfe.even-better-toml
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension usernamehw.errorlens
code --install-extension aaron-bond.better-comments
code --install-extension eamodio.gitlens
```

### AI Assistant Integration

This template is optimized for AI-assisted development:

- **Cursor AI**: Rules configured in `.cursor/rules/` and `.cursor/AGENTS.md`
- **GitHub Copilot**: Instructions in `.github/copilot-instructions.md`
- **Custom Commands**: Available in `.cursor/commands/` (e.g., `/commit` for guided commits)
- **Automated Hooks**: Quality checks run automatically via `.cursor/hooks/`

See [.cursor/AGENTS.md](`.cursor/AGENTS.md`) for AI assistant configuration details.

## Testing

```bash
# Run all tests
poetry run pytest

# Run with coverage
poetry run pytest --cov

# Run specific test file
poetry run pytest tests/test_main.py

# Run tests matching pattern
poetry run pytest -k "test_greet"

# Run with verbose output
poetry run pytest -v

# Generate HTML coverage report
poetry run poe test-cov
open htmlcov/index.html  # View coverage report
```

## Contributing

### Development Workflow

1. **Create a branch** for your feature or fix
   ```bash
   git checkout -b feat/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

2. **Make your changes** with AI assistance if desired
   - Write code following project conventions
   - Add tests for new functionality
   - Update documentation as needed

3. **Run quality checks** before committing
   ```bash
   poetry run poe all
   # or
   make all
   ```

4. **Commit with conventional commit message**
   ```bash
   git add .
   git commit -m "feat(scope): add new feature"
   # Pre-commit hooks will run automatically
   ```

5. **Push and create a Pull Request**
   ```bash
   git push -u origin feat/your-feature-name
   ```

### Code Standards

- **Type Hints**: Required for all functions
- **Docstrings**: Google-style for all public functions/classes
- **Test Coverage**: Maintain >= 80% coverage
- **Linting**: All Ruff checks must pass
- **Type Checking**: Strict mypy compliance required
- **Security**: No hardcoded secrets, Bandit checks must pass

### Pre-commit Hooks

Pre-commit hooks run automatically on `git commit`:
- Ruff formatting and linting
- mypy type checking
- Bandit security scanning
- detect-secrets credential detection
- Conventional commit validation

**Do not bypass** with `--no-verify` unless absolutely necessary.

### Conventional Commits

This project enforces [Conventional Commits](https://www.conventionalcommits.org/):

Format: `<type>(<scope>): <subject>`

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Test additions/updates
- `chore`: Maintenance tasks

**Examples**:
```bash
git commit -m "feat(auth): add OAuth2 login"
git commit -m "fix(api): resolve null pointer in user endpoint"
git commit -m "docs: update installation instructions"
git commit -m "test(parser): add edge case tests"
```

### Pull Request Process

1. Ensure all quality checks pass locally
2. Update CHANGELOG.md with your changes
3. Fill out the PR template completely
4. Request review from maintainers
5. Address feedback and push updates
6. Wait for approval and CI to pass
7. Maintainer will merge when ready

### Getting Help

- **Documentation**: Check `docs/` directory
- **Issues**: Open an issue for bugs or feature requests
- **Discussions**: Use GitHub Discussions for questions
- **AI Assistants**: Leverage Cursor/Copilot for coding help

## Documentation

Comprehensive documentation is available in the `docs/` directory:

- **[ARCHITECTURE.md](docs/ARCHITECTURE.md)**: Architectural decisions and patterns
- **[ARCHITECTURE.mermaid](docs/ARCHITECTURE.mermaid)**: Visual architecture diagram
- **[TECHNICAL.md](docs/TECHNICAL.md)**: Technical stack, tools, and configurations
- **[MEMORY_BANK.md](docs/MEMORY_BANK.md)**: Architectural Decision Records (ADR)
- **[PROJECT_SPEC.md](docs/PROJECT_SPEC.md)**: Project specification template
- **[CHANGELOG.md](docs/CHANGELOG.md)**: Version history and changes

## CI/CD

GitHub Actions workflows run automatically on push and pull requests:

- **Quality Checks**: Ruff, mypy, Bandit, tests with coverage
- **Pre-commit Validation**: Ensures all hooks pass
- **Security Audit**: Credential scanning and dependency checks

See [.github/workflows/README.md](.github/workflows/README.md) for workflow documentation.

## Troubleshooting

### Common Issues

**Virtual environment not activated:**
```bash
poetry shell  # Activate the virtual environment
# or
poetry run <command>  # Run commands without activating
```

**Pre-commit hooks fail:**
```bash
# Auto-fix most issues
poetry run poe lint-fix
poetry run poe format

# Then try committing again
```

**Type checking errors:**
```bash
# Run mypy to see errors
poetry run mypy src/

# Add type hints or type: ignore comments as needed
```

**Coverage below 80%:**
```bash
# Generate HTML coverage report
poetry run poe test-cov
open htmlcov/index.html

# Write tests for uncovered code
```

**Extensions not installing:**
```bash
# Try manual installation
bash .cursor/hooks/setup-extensions.sh

# Or install from IDE Extensions panel
```

## License

[Your License Here]

## Acknowledgments

This template is designed for AI-native development workflows with Cursor and GitHub Copilot integration.
