# Python Template - Balanced Edition

A streamlined Python project template for everyday use, side projects, and experiments. Based on the production-ready template but optimized for speed and simplicity.

## 🎯 Philosophy

**Fast to start. Easy to scale. Professional when needed.**

This template strikes a balance between:
- ✅ Quick setup (2-3 minutes)
- ✅ Essential quality tools
- ✅ Flexibility for experiments
- ✅ Ability to scale up

## 🚀 Quick Start

```bash
# Clone or copy this template
cd my-new-project

# One command setup
bash setup.sh

# Or manual setup
make setup

# Start coding!
```

## 📦 What's Included

### Core Tools
- **Poetry** - Modern dependency management
- **Ruff** - Lightning-fast linting and formatting
- **pytest** - Testing with 70% coverage threshold
- **mypy** - Type checking (relaxed mode)
- **pre-commit** - Automated quality checks

### IDE Support
- VSCode/Cursor settings pre-configured
- Format on save
- Auto-fix on save
- Type checking enabled
- Test discovery

### Project Structure
```
my-project/
├── src/              # Your code
├── tests/            # Your tests
├── .vscode/          # IDE settings
├── .cursor/          # AI assistant rules
├── pyproject.toml    # All configs in one place
├── Makefile          # Simple commands
└── README.md         # This file
```

## 🛠️ Development

### Daily Commands
```bash
make test       # Run tests
make format     # Format code
make check      # Run all checks
```

### Adding Dependencies
```bash
poetry add requests              # Runtime dependency
poetry add --group dev pytest-asyncio  # Dev dependency
```

### Running Tests
```bash
poetry run pytest           # All tests
poetry run pytest -v        # Verbose
poetry run pytest --cov     # With coverage
```

## 📊 Comparison with Production Template

| Feature | Production | Balanced |
|---------|-----------|----------|
| Setup time | 10 min | 3 min |
| Dev dependencies | 10+ | 5 |
| Coverage threshold | 80% | 70% |
| mypy strictness | Strict | Relaxed |
| Pre-commit hooks | 11 | 6 |
| Security scanning | ✅ | ❌ (add when needed) |
| CI/CD | ✅ | ❌ (add when needed) |

See [TEMPLATE_COMPARISON.md](TEMPLATE_COMPARISON.md) for detailed comparison.

## 🔄 Scaling Up

When your project grows, easily add:

```bash
# Security scanning
poetry add --group dev bandit detect-secrets

# Async testing
poetry add --group dev pytest-asyncio

# Parallel testing
poetry add --group dev pytest-xdist

# Stricter type checking
# In pyproject.toml: strict = true
```

## 📝 Code Quality

### Type Hints
Required for function signatures:
```python
def greet(name: str) -> str:
    return f"Hello, {name}!"
```

### Testing
Maintain 70%+ coverage:
```bash
make test-cov
open htmlcov/index.html
```

### Pre-commit Hooks
Run automatically on commit:
- File quality checks
- Ruff formatting
- Ruff linting
- mypy type checking

## 🎨 IDE Setup

### Recommended Extensions
- Ruff (charliermarsh.ruff)
- Python (ms-python.python)
- Pylance (ms-python.vscode-pylance)
- mypy (ms-python.mypy-type-checker)

Extensions are auto-suggested when you open the project.

## 💡 Tips for Everyday Use

1. **Start simple** - Skip tests initially, add them later
2. **Type hints** - Add as code stabilizes
3. **Coverage** - 70% is a good balance
4. **Pre-commit** - Let it guide you
5. **Ruff** - Trust the auto-fixes

## 🆚 When to Use This Template

### ✅ Use Balanced Template For:
- Side projects
- Experiments
- Learning
- Prototypes
- Solo work
- Quick ideas

### ❌ Use Production Template For:
- Production apps
- Team projects
- Security-critical code
- Open source projects
- Enterprise work

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📜 License

[Your License Here]

## 🙏 Acknowledgments

Based on the comprehensive production-ready Python template, streamlined for everyday use.

---

**Happy coding! 🚀**
