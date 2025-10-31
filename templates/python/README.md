# Python Project Template

Production-ready Python project template with poetry, testing, linting, and CI/CD.

## Features

- ✅ Poetry for dependency management
- ✅ pytest for testing
- ✅ Ruff for linting (10-100x faster than flake8)
- ✅ Black for formatting
- ✅ isort for import sorting
- ✅ mypy for type checking
- ✅ pre-commit hooks
- ✅ GitHub Actions CI/CD
- ✅ AI-native with Cursor rules

## Quick Start

```bash
# Create new project from template
cp -r path/to/templates/python my-project
cd my-project

# Install poetry if not already installed
curl -sSL https://install.python-poetry.org | python3 -

# Install dependencies
poetry install

# Run tests
poetry run pytest

# Run linting
poetry run ruff check

# Run formatting
poetry run black .
```

## Project Structure

```
my-project/
├── .cursorrules           # Cursor AI rules
├── .github/
│   └── workflows/
│       └── ci.yml         # GitHub Actions CI
├── .pre-commit-config.yaml
├── src/
│   └── my_project/
│       ├── __init__.py
│       ├── main.py
│       └── py.typed       # PEP 561 marker
├── tests/
│   ├── __init__.py
│   └── test_main.py
├── pyproject.toml         # Poetry + tool configs
├── poetry.lock            # Locked dependencies
├── .python-version        # Python version
└── README.md
```

## Scripts

```bash
# Development
poetry run python -m my_project

# Testing
poetry run pytest                    # Run all tests
poetry run pytest -v                 # Verbose output
poetry run pytest --cov              # With coverage
poetry run pytest -k test_name       # Run specific test

# Code Quality
poetry run ruff check                # Linting
poetry run ruff check --fix          # Auto-fix
poetry run black .                   # Formatting
poetry run isort .                   # Import sorting
poetry run mypy src                  # Type checking

# Combined Quality Check
poetry run ruff check && poetry run black --check . && poetry run isort --check . && poetry run mypy src

# Pre-commit
poetry run pre-commit install        # Setup hooks
poetry run pre-commit run --all-files  # Manual run

# Dependencies
poetry add package-name              # Add runtime dep
poetry add --group dev package-name  # Add dev dep
poetry update                        # Update all deps
poetry show --outdated               # Check for updates
```

## Configuration

### Python Version

Specified in `.python-version`:

```
3.11.7
```

### Poetry Configuration

All configuration in `pyproject.toml`:

```toml
[tool.poetry]
name = "my-project"
version = "0.1.0"
description = "Project description"
authors = ["Your Name <you@example.com>"]

[tool.poetry.dependencies]
python = "^3.11"

[tool.poetry.group.dev.dependencies]
pytest = "^7.4.3"
pytest-cov = "^4.1.0"
ruff = "^0.1.8"
black = "^23.12.1"
isort = "^5.13.2"
mypy = "^1.7.1"
pre-commit = "^3.6.0"
```

### Testing with pytest

```toml
[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py", "*_test.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
addopts = [
    "--strict-markers",
    "--cov=src",
    "--cov-report=term-missing",
    "--cov-report=html",
    "--cov-report=xml",
    "--cov-fail-under=80"
]
```

### Linting with Ruff

Ruff combines the functionality of flake8, isort, pylint, and more:

```toml
[tool.ruff]
line-length = 100
target-version = "py311"

[tool.ruff.lint]
select = [
    "E",   # pycodestyle errors
    "W",   # pycodestyle warnings
    "F",   # pyflakes
    "I",   # isort
    "B",   # flake8-bugbear
    "C4",  # flake8-comprehensions
    "UP",  # pyupgrade
]
```

### Formatting with Black

```toml
[tool.black]
line-length = 100
target-version = ['py311']
```

### Type Checking with mypy

```toml
[tool.mypy]
python_version = "3.11"
strict = true
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
```

## AI Integration

This template includes Cursor rules that ensure:

- Tests always run after code changes
- poetry is used exclusively (no pip or conda)
- Ruff, Black, isort, and mypy pass before commits
- Documentation stays up to date
- Type hints are used consistently

## Best Practices

### Project Organization

```python
src/
  my_project/
    __init__.py          # Package initialization
    main.py              # Entry point
    core/                # Core business logic
      __init__.py
      models.py
      services.py
    utils/               # Utilities
      __init__.py
      helpers.py
    py.typed             # PEP 561 marker for type checking

tests/
  __init__.py
  conftest.py            # pytest fixtures
  test_main.py
  unit/                  # Unit tests
    test_models.py
  integration/           # Integration tests
    test_services.py
```

### Type Hints

```python
from typing import Optional, List, Dict, Union
from collections.abc import Sequence

def process_items(
    items: Sequence[str],
    max_count: Optional[int] = None
) -> Dict[str, int]:
    """Process items and return counts.
    
    Args:
        items: Sequence of items to process
        max_count: Optional maximum count limit
        
    Returns:
        Dictionary mapping items to counts
        
    Raises:
        ValueError: If max_count is negative
    """
    if max_count is not None and max_count < 0:
        raise ValueError("max_count must be non-negative")
    
    result: Dict[str, int] = {}
    for item in items:
        result[item] = result.get(item, 0) + 1
    
    return result
```

### Testing

```python
import pytest
from my_project.main import process_items

def test_process_items_empty():
    """Test with empty sequence."""
    assert process_items([]) == {}

def test_process_items_basic():
    """Test basic functionality."""
    result = process_items(["a", "b", "a"])
    assert result == {"a": 2, "b": 1}

def test_process_items_with_max_count():
    """Test with max_count parameter."""
    result = process_items(["a", "b"], max_count=10)
    assert len(result) <= 10

def test_process_items_negative_max_count():
    """Test that negative max_count raises ValueError."""
    with pytest.raises(ValueError, match="must be non-negative"):
        process_items(["a"], max_count=-1)

@pytest.fixture
def sample_items():
    """Fixture providing sample items."""
    return ["item1", "item2", "item1"]

def test_with_fixture(sample_items):
    """Test using fixture."""
    result = process_items(sample_items)
    assert result["item1"] == 2
```

### Error Handling

```python
from typing import TypeVar, Generic
from dataclasses import dataclass

T = TypeVar('T')
E = TypeVar('E', bound=Exception)

@dataclass
class Success(Generic[T]):
    """Success result."""
    value: T

@dataclass
class Failure(Generic[E]):
    """Failure result."""
    error: E

Result = Success[T] | Failure[E]

def divide(a: float, b: float) -> Result[float, ValueError]:
    """Divide a by b, returning Result."""
    if b == 0:
        return Failure(ValueError("Division by zero"))
    return Success(a / b)

# Usage
result = divide(10, 2)
match result:
    case Success(value):
        print(f"Result: {value}")
    case Failure(error):
        print(f"Error: {error}")
```

### Logging

```python
import logging
from typing import Any

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

logger = logging.getLogger(__name__)

def process_data(data: dict[str, Any]) -> None:
    """Process data with structured logging."""
    logger.info("Processing data", extra={
        "data_size": len(data),
        "data_keys": list(data.keys())
    })
    
    try:
        # Process data...
        logger.debug("Processing step 1")
        # ...
    except Exception as e:
        logger.error("Failed to process data", exc_info=True, extra={
            "error_type": type(e).__name__
        })
        raise
```

## CI/CD

GitHub Actions workflow runs on every push and PR:

1. Setup Python and Poetry
2. Install dependencies
3. Run Ruff linting
4. Run Black formatting check
5. Run isort check
6. Run mypy type checking
7. Run pytest with coverage
8. Upload coverage report

## Troubleshooting

### Poetry Issues

```bash
# Clear poetry cache
poetry cache clear pypi --all

# Remove virtual environment and reinstall
poetry env remove python
poetry install
```

### Test Failures

```bash
# Run with verbose output
poetry run pytest -vv

# Run specific test
poetry run pytest tests/test_main.py::test_function_name

# Run with print output
poetry run pytest -s
```

### Type Checking Errors

```bash
# Run mypy with verbose output
poetry run mypy src --show-error-codes

# Check specific file
poetry run mypy src/my_project/main.py
```

### Pre-commit Issues

```bash
# Update hooks
poetry run pre-commit autoupdate

# Clean and reinstall
poetry run pre-commit clean
poetry run pre-commit install
```

## Publishing

```bash
# Build package
poetry build

# Check package
poetry run twine check dist/*

# Publish to PyPI
poetry publish

# Publish to Test PyPI
poetry publish -r testpypi
```

## License

MIT
