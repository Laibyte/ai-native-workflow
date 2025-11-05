# Setup Instructions

```bash 
# 1. Create project directory
mkdir my-project && cd my-project

# 2. Initialize Poetry project
poetry init --no-interaction

# 3. Create all files above

# 4. Install dependencies
poetry install

# 5. Setup pre-commit hooks
poetry run poe setup
# or
make setup

# 6. Run initial checks
poetry run pre-commit run --all-files

# 7. Start coding!
poetry shell
```

# 1. Create project
mkdir my-project && cd my-project

# 2. Initialize Poetry
poetry init --no-interaction

# 3. Create all directories
mkdir -p src/my_project tests .cursor/hooks .cursor/rules .vscode

# 4. Copy all files from above into your project

# 5. Install dependencies
poetry install

# 6. Setup hooks
bash .cursor/hooks/setup.sh

# 7. Initialize detect-secrets baseline
poetry run detect-secrets scan > .secrets.baseline

# 8. Setup pre-commit hooks
poetry run pre-commit install
poetry run pre-commit install --hook-type commit-msg

# 9. Run initial checks
poetry run pre-commit run --all-files

# 10. Start coding in Cursor!

# Usage Examples 

```bash 
# Daily workflow
poetry shell                      # Activate virtual environment
poetry run poe test              # Run tests
git add .
git commit -m "feat: add feature" # Pre-commit runs automatically
git push                          # Full test suite runs

# Before submitting PR
poetry run poe all               # Run all checks
make all                         # Alternative

# Check coverage
poetry run poe test-cov          # Opens htmlcov/index.html

# Fix all auto-fixable issues
poetry run poe lint-fix
poetry run poe format

# Manual security check
poetry run poe security
```