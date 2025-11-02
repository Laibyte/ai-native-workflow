#!/bin/bash

# Project Boilerplates & Initialization
# Here is the plan for your "NPX-style" project initializer. I'll provide a bash script that acts as this initializer. You can adapt this into an npx tool later.

# Save this as init-project.sh and make it executable ("chmod +x init-project.sh").

echo "🚀 Let's set up a new AI-first project."

# Ask questions
read -p "Project Name (e.g., my-awesome-app): " PROJECT_NAME
read -p "Project Goal (e.g., A blog that deploys to Cloudflare): " PROJECT_GOAL
read -p "Project Stack (1: React/TS, 2: Python/Poetry): " STACK_CHOICE

# Create project directory
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"

echo "Setting up $PROJECT_NAME..."

# Create core AI docs
echo "Initializing AI-friendly documentation..."
mkdir -p docs
touch docs/architecture.md
touch docs/technical.md
echo "# Project Spec: $PROJECT_NAME" > docs/technical.md
echo "- **Goal:** $PROJECT_GOAL" >> docs/technical.md

# Create .cursorignore
echo "Creating .cursorignore..."
cat << 'EOF' > .cursorignore
node_modules/
.venv/
dist/
build/
.env
*.log
EOF

# --- Stack-Specific Setup ---

if [ "$STACK_CHOICE" = "1" ]; then
    echo "Initializing React/TS project with NPM..."
    npm init -y
    npm install react react-dom @types/react @types/react-dom typescript
    npm install --save-dev husky lint-staged prettier eslint @commitlint/cli @commitlint/config-conventional secretlint @secretlint/preset-recommend
    
    # Create AGENTS.md for TS
    cat << EOF > AGENTS.md
# AI Agent Instructions for $PROJECT_NAME
- **Goal:** $PROJECT_GOAL
- **Stack:** React, TypeScript, Node.js
- **Principles:** TDD (use Jest/Vitest), Conventional Commits, `npm run lint`
- **Docs:** See \`docs/technical.md\` for specs.
- **Workflow:** Plan -> Code -> Test (`npm test`) -> Lint (`npm run lint`) -> Commit
EOF
    # Setup package.json (simplified)
    # In a real tool, you'd use 'jq' or similar to edit package.json
    echo "-> Remember to configure husky, lint-staged, and commitlint in package.json!"

elif [ "$STACK_CHOICE" = "2" ]; then
    echo "Initializing Python project with Poetry..."
    poetry init --name "$PROJECT_NAME" --description "$PROJECT_GOAL" -n
    poetry add python
    poetry add --group dev pytest ruff pre-commit
    
    # Create AGENTS.md for Python
    cat << EOF > AGENTS.md
# AI Agent Instructions for $PROJECT_NAME
- **Goal:** $PROJECT_GOAL
- **Stack:** Python, Poetry, FastAPI (example)
- **Principles:** TDD (use Pytest), PEP 8, Conventional Commits, \`poetry run ruff check . \`
- **Docs:** See \`docs/technical.md\` for specs.
- **Workflow:** Plan -> Code -> Test (\`poetry run pytest\`) -> Lint (\`poetry run ruff check .\`) -> Commit
EOF
    echo "-> Remember to create .pre-commit-config.yaml and run 'poetry run pre-commit install'!"
fi

# Final step
echo "Initializing Git..."
git init
git add .
git commit -m "feat: initial project setup"

echo "✅ Done! Your new project '$PROJECT_NAME' is ready."
echo "Next steps:"
echo "1. cd $PROJECT_NAME"
echo "2. Finish configuring package.json (husky/lint-staged) or .pre-commit-config.yaml"
echo "3. Start coding with Cursor!"