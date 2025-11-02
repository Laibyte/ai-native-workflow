#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# Find all.js files in src/ and run the agent on each one
find src/ -name "*.js" | while read file; do
    echo "Adding JSDoc comments to $file..."
    # Use --force to apply changes directly to the file
    cursor-agent -p --force "Add comprehensive JSDoc comments to all functions in $file. Modify the file in-place."
done

echo "Batch documentation complete."