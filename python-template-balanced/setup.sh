#!/bin/bash
# Quick setup script for balanced Python template

set -e

echo "🚀 Setting up balanced Python template..."
echo ""

# Check Poetry
if ! command -v poetry &> /dev/null; then
  echo "❌ Poetry not found. Install it first:"
  echo "   curl -sSL https://install.python-poetry.org | python3 -"
  exit 1
fi
echo "✅ Poetry found"

# Check Python version
REQUIRED_PYTHON="3.11"
PYTHON_VERSION=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)
if [ "$(printf '%s\n' "$REQUIRED_PYTHON" "$PYTHON_VERSION" | sort -V | head -n1)" != "$REQUIRED_PYTHON" ]; then
  echo "❌ Python $REQUIRED_PYTHON or higher required (found $PYTHON_VERSION)"
  exit 1
fi
echo "✅ Python $PYTHON_VERSION found"

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
poetry install

# Install pre-commit hooks
echo ""
echo "🪝 Installing pre-commit hooks..."
poetry run pre-commit install

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Setup complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📚 Quick commands:"
echo "   make test        - Run tests"
echo "   make format      - Format code"
echo "   make check       - Run all checks"
echo ""
echo "🎯 Next steps:"
echo "   1. Open in VSCode/Cursor"
echo "   2. Start coding!"
echo ""
