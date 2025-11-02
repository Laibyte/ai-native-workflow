#!/usr/bin/env bash
# simple-code-review.sh - Basic code review script 

# This script  reviews recent, staged git changes and saves the AI's feedback to a review.txt file, allowing an engineer to get an AI review before committing.

set -o errexit
set -o nounset
set -o pipefail

echo "Starting code review of staged changes..."
REVIEW_FILE="review.txt"

# Get the staged diff
STAGED_DIFF=$(git --no-pager diff --cached)

if; then
  echo "No staged changes to review."
  exit 0
fi

# Send the diff to the agent and save output to review.txt
cursor-agent -p --force --output-format text \
  "Review the following code changes (git diff) and provide feedback on:
  1. Code quality and readability
  2. Potential bugs or issues
  3. Security considerations
  4. Best practices compliance
  Provide specific suggestions for improvement.
  
  DIFF:
  $STAGED_DIFF" > $REVIEW_FILE

echo "✅ Code review complete!"
echo "📄 Review saved to $REVIEW_FILE"

# Show summary
if]; then
  echo ""
  echo "📋 Review Summary:"
  echo "=================="
  head -10 "$REVIEW_FILE"
  echo ""
  echo "📖 Full review available in $REVIEW_FILE"
fi