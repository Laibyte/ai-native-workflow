#!/bin/bash
# Auto-format and lint after file edits

read -r payload

# Extract file path
file_path=$(echo "$payload" | jq -r '.file_path')

# Only process Python files
if [[ "$file_path" =~ \.py$ ]]; then
  # Run ruff format
  poetry run ruff format "$file_path" 2>/dev/null
  
  # Run ruff check with auto-fix
  poetry run ruff check --fix "$file_path" 2>/dev/null
  
  # Log the action
  echo "$(date +%Y-%m-%d\ %H:%M:%S) - Formatted and linted: $file_path" >> .cursor/hooks.log
fi

exit 0
