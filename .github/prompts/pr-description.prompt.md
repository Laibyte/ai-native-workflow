---
mode: "agent"
model: "gpt-4o"  # Use a capable model for detailed analysis
tools: ["github"]  # Access GitHub context for diffs/PRs
description: "Generate detailed PR description from changes"
---

# Generate PR Description

Analyze the current workspace changes and generate a comprehensive PR description following our standards (.github/copilot-instructions.md).

## Requirements
-  **Title**: ${input:prTitle:Enter a concise PR title}
-  **Summary**: 2-3 sentences explaining the changes and why they matter.
-  **Key Changes**: Bullet list of features/fixes, referencing specific files (#src/components/).
-  **Testing**: How to verify (e.g., unit tests added).
-  **Breaking Changes**: If any, explain impact.
-  **Related Issues**: Link to tickets (e.g., #123).

Context: @workspace /get_changed_files
Use semantic versioning if applicable.
Output in Markdown format for GitHub PR.