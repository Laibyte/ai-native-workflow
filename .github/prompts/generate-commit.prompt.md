---
mode: "agent"
model: "gpt-4o"  # Use a capable model for analyzing changes
tools: ["git"]  # Access git context for diffs and status
description: "Generate conventional commit messages from workspace changes"
---

# Generate Commit Messages

Analyze the current git status and staged/unstaged changes to generate appropriate commit messages following Conventional Commits specification.

## Requirements
- **Format**: `<type>(<scope>): <subject>`
- **Types**: feat, fix, docs, style, refactor, test, chore
- **Subject**: Imperative mood, lowercase, no period, max 50 chars
- **Scope**: Optional, indicates affected component/module

## Examples
- `feat(auth): implement password reset endpoint`
- `fix(api): correct pagination logic for user list`
- `docs(readme): update setup instructions`
- `chore(deps): update react to latest version`

Context: @workspace
Use git status and diff to understand changes.
Generate 1-3 commit message options with explanations.