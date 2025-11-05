.PHONY: install setup test test-cov lint lint-fix format type-check pre-commit security all clean help

help:
	@echo "Available commands:"
	@echo "  make install      - Install dependencies"
	@echo "  make setup        - Complete project setup"
	@echo "  make test         - Run tests"
	@echo "  make test-cov     - Run tests with coverage"
	@echo "  make lint         - Run linting"
	@echo "  make lint-fix     - Run linting with auto-fix"
	@echo "  make format       - Format code"
	@echo "  make type-check   - Run type checking"
	@echo "  make security     - Run security checks"
	@echo "  make pre-commit   - Run pre-commit hooks"
	@echo "  make all          - Run all checks"
	@echo "  make clean        - Clean up generated files"

install:
	poetry install

setup:
	poetry install
	poetry run pre-commit install
	poetry run pre-commit install --hook-type commit-msg
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

type-check:
	poetry run mypy src/

security:
	poetry run bandit -c pyproject.toml -r src/

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
