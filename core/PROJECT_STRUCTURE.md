/
├──.cursor/
│   └── rules/
│       ├── index.mdc           # (Rule Type: Always) Main AI context loader
│       ├── react.mdc           # (Rule Type: Auto Attached) React-specific rules
│       ├── python.mdc          # (Rule Type: Auto Attached) Python-specific rules
│       └── tdd.mdc             # (Rule Type: Auto Attached) TDD workflow rules
├──.github/
│   ├── workflows/              # (CI/CD workflows)
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── ISSUE_TEMPLATE.md
├── docs/
│   ├── ARCHITECTURE.md         # High-level design, patterns, stack
│   ├── technical.md            # Core technical specs, API standards
│   ├── architecture.mermaid    # Mermaid diagram of system components
│   └── MEMORY_BANK.md          # Log of key decisions, patterns, "how-to" guides
├── AGENTS.md                   # High-level AI instructions, stack, commands
├── src/
│   └──... (project code)
└──... (config files: package.json, pyproject.toml, etc.)