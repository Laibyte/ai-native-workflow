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

### Installation

```bash
# Clone the repository
git clone <your-repo-url>
cd my-project

# Setup (installs dependencies and pre-commit hooks)
make setup

# Or manually
poetry install
poetry run poe setup
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
├── src/
│   └── my_project/          # Source code
│       ├── __init__.py
│       └── main.py
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

## VS Code / Cursor Setup

The project includes VS Code/Cursor configuration for:
- Auto-format on save with Ruff	
- Auto-fix linting issues on save
- Type checking with mypy
- Python test discovery
- Recommended extensions

Install recommended extensions when prompted, or manually:
```bash
code --install-extension charliermarsh.ruff
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.mypy-type-checker
```

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
```
