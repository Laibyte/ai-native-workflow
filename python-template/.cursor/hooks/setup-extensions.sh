#!/bin/bash
# Auto-install VSCode/Cursor extensions from extensions.json

set -e

EXTENSIONS_FILE=".vscode/extensions.json"

# Check if extensions.json exists
if [ ! -f "$EXTENSIONS_FILE" ]; then
  echo "❌ No extensions.json found at $EXTENSIONS_FILE"
  exit 1
fi

# Determine which command to use (code for VSCode, cursor for Cursor)
CMD=""
if command -v cursor &> /dev/null; then
  CMD="cursor"
  echo "📦 Installing Cursor extensions..."
elif command -v code &> /dev/null; then
  CMD="code"
  echo "📦 Installing VSCode extensions..."
else
  echo "⚠️  Neither 'cursor' nor 'code' command found."
  echo "💡 Extensions must be installed manually from the IDE:"
  echo "   - Open Command Palette (Cmd/Ctrl + Shift + P)"
  echo "   - Search 'Extensions: Show Recommended Extensions'"
  echo "   - Click 'Install All'"
  exit 0
fi

# Extract extension IDs from extensions.json using Python
# (jq might not be available yet during initial setup)
EXTENSIONS=$(python3 -c "
import json
import sys

try:
    with open('$EXTENSIONS_FILE', 'r') as f:
        data = json.load(f)
        recommendations = data.get('recommendations', [])
        for ext in recommendations:
            print(ext)
except Exception as e:
    sys.exit(1)
")

if [ -z "$EXTENSIONS" ]; then
  echo "⚠️  No extensions found in $EXTENSIONS_FILE"
  exit 0
fi

# Install each extension
echo ""
echo "Installing extensions:"
INSTALLED=0
FAILED=0

while IFS= read -r extension; do
  echo -n "  - $extension ... "

  # Check if already installed
  if $CMD --list-extensions 2>/dev/null | grep -qi "^$extension$"; then
    echo "✅ already installed"
  else
    # Install extension
    if $CMD --install-extension "$extension" --force > /dev/null 2>&1; then
      echo "✅ installed"
      ((INSTALLED++))
    else
      echo "❌ failed"
      ((FAILED++))
    fi
  fi
done <<< "$EXTENSIONS"

echo ""
if [ $INSTALLED -gt 0 ]; then
  echo "✅ Installed $INSTALLED new extension(s)"
fi

if [ $FAILED -gt 0 ]; then
  echo "⚠️  $FAILED extension(s) failed to install"
  echo "💡 Try installing them manually from the Extensions panel"
fi

echo ""
echo "🎯 Recommended: Restart your IDE to activate all extensions"
