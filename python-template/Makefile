.PHONY: install setup init-secrets test test-cov lint lint-fix format format-check type-check pre-commit security check-secrets check-outdated build all clean help

help:
	@echo "Available commands:"
	@echo "  make install         - Install dependencies"
	@echo "  make setup           - Complete project setup"
	@echo "  make init-secrets    - Initialize detect-secrets baseline"
	@echo "  make test            - Run tests"
	@echo "  make test-cov        - Run tests with coverage"
	@echo "  make lint            - Run linting"
	@echo "  make lint-fix        - Run linting with auto-fix"
	@echo "  make format          - Format code"
	@echo "  make format-check    - Check code formatting without modifying"
	@echo "  make type-check      - Run type checking"
	@echo "  make security        - Run security checks"
	@echo "  make check-secrets   - Scan for secrets using baseline"
	@echo "  make check-outdated  - Check for outdated dependencies"
	@echo "  make pre-commit      - Run pre-commit hooks"
	@echo "  make build           - Build package distributions"
	@echo "  make all             - Run all checks"
	@echo "  make clean           - Clean up generated files"

install:
	poetry install

init-secrets:
	@echo "🔒 Initializing detect-secrets baseline..."
	poetry run detect-secrets scan > .secrets.baseline  # pragma: allowlist secret
	@echo "✅ Secrets baseline created"

setup:
	@echo "🚀 Setting up project..."
	poetry install
	@chmod +x .cursor/hooks/*.sh 2>/dev/null || true
	poetry run pre-commit install
	poetry run pre-commit install --hook-type commit-msg
	@if [ ! -f ".secrets.baseline" ]; then \
		echo "🔒 Initializing detect-secrets baseline..."; \
		poetry run detect-secrets scan > .secrets.baseline; \
		echo "✅ Secrets baseline created"; \
	fi
	@echo "✅ Setup complete! Start coding."

test:
	poetry run pytest

test-cov:
	poetry run pytest --cov --cov-report=html
	@echo "Coverage report generated in htmlcov/index.html"

lint:
	poetry run ruff check .

lint-fix:
	poetry run ruff check --fix .

format:
	poetry run ruff format .

format-check:
	poetry run ruff format --check .

type-check:
	poetry run mypy src/

security:
	poetry run bandit -c pyproject.toml -r src/

check-secrets:
	poetry run detect-secrets scan --baseline .secrets.baseline  # pragma: allowlist secret

check-outdated:
	poetry show --outdated

build:
	poetry build
	@echo "✅ Package built successfully in dist/"

pre-commit:
	poetry run pre-commit run --all-files

all: lint-fix format type-check test
	@echo "✅ All checks passed!"

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".mypy_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	rm -rf htmlcov/ dist/ build/
	@echo "✅ Cleaned up generated files"
