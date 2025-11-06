# Quick Reference Guide

## 🚀 Setup (First Time)

```bash
# Navigate to project
cd my-project

# Quick setup (recommended)
bash setup.sh

# Or manual setup
poetry install
poetry run pre-commit install
```

## 📝 Daily Commands

### Testing
```bash
make test           # Run all tests
make test-cov       # Run tests with HTML coverage report

# Or directly
poetry run pytest
poetry run pytest -v
poetry run pytest --cov
poetry run pytest tests/test_main.py
```

### Code Quality
```bash
make format         # Format code with Ruff
make lint           # Check code quality
make type-check     # Run mypy type checking
make check          # Run all checks (format + type-check + test)
```

### Cleanup
```bash
make clean          # Remove cache files and build artifacts
```

## 📦 Managing Dependencies

### Add Dependencies
```bash
# Runtime dependency
poetry add requests
poetry add pandas numpy

# Dev dependency
poetry add --group dev pytest-asyncio
poetry add --group dev ipython

# Specific version
poetry add "requests>=2.28.0"
```

### Remove Dependencies
```bash
poetry remove requests
poetry remove --group dev pytest-asyncio
```

### Update Dependencies
```bash
poetry update              # Update all
poetry update requests     # Update specific package
poetry show --outdated     # Check for updates
```

## 🧪 Testing Patterns

### Basic Test
```python
def test_function():
    result = my_function()
    assert result == expected
```

### Test with Fixture
```python
def test_with_fixture(sample_data):
    result = process(sample_data)
    assert result is not None
```

### Parametrized Test
```python
import pytest

@pytest.mark.parametrize("input,expected", [
    ("hello", "HELLO"),
    ("world", "WORLD"),
])
def test_uppercase(input, expected):
    assert input.upper() == expected
```

### Test Exceptions
```python
import pytest

def test_raises_error():
    with pytest.raises(ValueError):
        my_function(invalid_input)
```

## 🎨 Code Style

### Type Hints
```python
# Required for functions
def greet(name: str) -> str:
    return f"Hello, {name}!"

# Optional for variables (but recommended)
count: int = 0
names: list[str] = []
```

### Docstrings
```python
def calculate(x: int, y: int) -> int:
    """Calculate the sum of two numbers.

    Args:
        x: First number
        y: Second number

    Returns:
        The sum of x and y
    """
    return x + y
```

### F-strings
```python
# Use f-strings for formatting
name = "Alice"
message = f"Hello, {name}!"

# Not this
message = "Hello, " + name + "!"
message = "Hello, {}!".format(name)
```

## 🔧 Configuration Files

### pyproject.toml
All tool configurations in one place:
- Poetry dependencies
- Ruff linting/formatting
- mypy type checking
- pytest testing
- Coverage reporting

### .pre-commit-config.yaml
Git hooks that run automatically:
- File quality checks
- Ruff formatting
- Ruff linting
- mypy type checking

### .vscode/settings.json
IDE settings:
- Format on save
- Auto-fix on save
- Type checking
- Test discovery

## 🐛 Troubleshooting

### Virtual Environment Issues
```bash
# Recreate environment
poetry env remove python
poetry install

# Activate environment
poetry shell

# Run command without activating
poetry run python script.py
```

### Pre-commit Hook Failures
```bash
# Fix formatting issues
make format

# Run hooks manually
poetry run pre-commit run --all-files

# Skip hooks (use sparingly)
git commit --no-verify
```

### Type Checking Errors
```bash
# Run mypy
poetry run mypy src/

# Ignore specific line
result = third_party_function()  # type: ignore

# Ignore specific error
result = function()  # type: ignore[arg-type]
```

### Coverage Too Low
```bash
# Generate HTML report
make test-cov
open htmlcov/index.html

# See what's not covered
poetry run pytest --cov --cov-report=term-missing

# Exclude from coverage
def debug_function():  # pragma: no cover
    print("Debug info")
```

## 📊 Git Workflow

### Commit Messages
```bash
# Good commit messages
git commit -m "Add user authentication"
git commit -m "Fix bug in data processing"
git commit -m "Update README with setup instructions"

# With type prefix (optional but nice)
git commit -m "feat: add user authentication"
git commit -m "fix: resolve data processing bug"
git commit -m "docs: update README"
```

### Before Committing
```bash
# Run all checks
make check

# Or individually
make format
make type-check
make test
```

## 🔄 Scaling Up

### Add Security Scanning
```bash
poetry add --group dev bandit detect-secrets

# Add to pre-commit-config.yaml
# See production template for config
```

### Add Async Testing
```bash
poetry add --group dev pytest-asyncio

# Use in tests
@pytest.mark.asyncio
async def test_async_function():
    result = await async_function()
    assert result is not None
```

### Enable Strict Type Checking
```toml
# In pyproject.toml
[tool.mypy]
strict = true
```

### Add CI/CD
```bash
# Copy from production template
cp ../python-template/.github/workflows/python-ci.yml .github/workflows/
```

## 💡 Tips

1. **Run `make check` before committing** - Catches issues early
2. **Use `poetry shell`** - Activates virtual environment
3. **Trust Ruff's auto-fixes** - They're fast and safe
4. **Write tests as you code** - Easier than adding later
5. **Use type hints** - Catches bugs before runtime
6. **Keep coverage above 70%** - Good balance for side projects
7. **Let pre-commit guide you** - It enforces good practices

## 🆘 Getting Help

```bash
# Poetry help
poetry --help
poetry add --help

# pytest help
poetry run pytest --help

# Ruff help
poetry run ruff --help

# mypy help
poetry run mypy --help
```

## 📚 Resources

- [Poetry Docs](https://python-poetry.org/docs/)
- [Ruff Docs](https://docs.astral.sh/ruff/)
- [pytest Docs](https://docs.pytest.org/)
- [mypy Docs](https://mypy.readthedocs.io/)

---

**Keep this handy for quick reference! 📌**
