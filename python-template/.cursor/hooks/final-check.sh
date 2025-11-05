#!/bin/bash
# Final checks when agent task completes

read -r payload

status=$(echo "$payload" | jq -r '.status')

# Log completion
echo "$(date +%Y-%m-%d\ %H:%M:%S) - Task completed with status: $status" >> .cursor/hooks.log

# Run full quality checks
echo "Running final quality checks..."

# Type checking
if poetry run mypy src/ 2>&1 | grep -q "error"; then
  echo "⚠️  Type checking found issues. Please review."
fi

# Linting
if poetry run ruff check . 2>&1 | grep -q "error"; then
  echo "⚠️  Linting found issues. Please review."
fi

# Show notification (macOS)
if command -v osascript &> /dev/null; then
  osascript -e 'display notification "Agent task completed" with title "Cursor" sound name "Glass"'
fi

exit 0
