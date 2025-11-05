#!/bin/bash
# Setup script for Cursor AI-native development environment

set -e

echo "🚀 Setting up AI-native Python development environment..."
echo ""

# Check prerequisites
echo "📋 Checking prerequisites..."

# Check Poetry
if ! command -v poetry &> /dev/null; then
  echo "❌ Poetry not found. Please install Poetry first:"
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

# Install jq for JSON parsing in hooks
if ! command -v jq &> /dev/null; then
  echo "📦 Installing jq (required for Cursor hooks)..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v brew &> /dev/null; then
      brew install jq
    else
      echo "⚠️  Homebrew not found. Please install jq manually: https://stedolan.github.io/jq/"
    fi
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt-get &> /dev/null; then
      sudo apt-get update && sudo apt-get install -y jq
    else
      echo "⚠️  apt-get not found. Please install jq manually: https://stedolan.github.io/jq/"
    fi
  fi
fi

# Make all hook scripts executable
echo ""
echo "🔧 Setting up Cursor hooks..."
chmod +x .cursor/hooks/*.sh
echo "✅ Hook scripts made executable"

# Create logs directory
mkdir -p .cursor
touch .cursor/hooks.log

# Install Python dependencies
echo ""
echo "📦 Installing Python dependencies..."
poetry install
echo "✅ Dependencies installed"

# Install pre-commit hooks
echo ""
echo "🪝 Installing pre-commit hooks..."
poetry run pre-commit install
poetry run pre-commit install --hook-type commit-msg
echo "✅ Pre-commit hooks installed"

# Initialize detect-secrets baseline if missing
if [ ! -f ".secrets.baseline" ]; then
  echo ""
  echo "🔒 Initializing detect-secrets baseline..."
  poetry run detect-secrets scan > .secrets.baseline
  echo "✅ Secrets baseline created"
fi

# Run initial pre-commit checks
echo ""
echo "🧪 Running initial quality checks..."
if poetry run pre-commit run --all-files; then
  echo "✅ All checks passed!"
else
  echo "⚠️  Some checks failed. This is normal for a new setup."
  echo "💡 Run: poetry run poe lint-fix && poetry run poe format"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Setup complete! Your environment is ready."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📚 Quick Start:"
echo "   poetry run poe test          # Run tests"
echo "   poetry run poe lint-fix      # Fix linting issues"
echo "   poetry run poe format        # Format code"
echo "   poetry run poe all           # Run all checks"
echo ""
echo "   Or use make commands:"
echo "   make test          # Run tests"
echo "   make lint-fix      # Fix linting"
echo "   make all           # Run all checks"
echo ""
echo "🎯 Next steps:"
echo "   1. Open project in Cursor/VSCode"
echo "   2. Install recommended extensions (you'll be prompted)"
echo "   3. Start coding with AI assistance!"
echo ""
