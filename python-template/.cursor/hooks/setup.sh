#!/bin/bash
# Setup hooks - run this once

# Make all hook scripts executable
chmod +x .cursor/hooks/*.sh

# Install jq if not present (required for JSON parsing)
if ! command -v jq &> /dev/null; then
  echo "Installing jq..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install jq
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get install -y jq
  fi
fi

# Create logs directory
mkdir -p .cursor

echo "✅ Cursor hooks setup complete!"
echo "Hooks will now run automatically when using Cursor AI assistant."
