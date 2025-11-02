# AI Agent Instructions for [Project Name]

## 1. Project Overview
- **Goal:** [Describe the project's purpose in one sentence.]
- **Tech Stack:** [e.g., React, TypeScript, Node.js, Cloudflare Pages]
- **Key Libraries:** [e.g., React Query, Zustand, FastAPI, Prisma]

## 2. Core Principles
- **TDD:** All new logic MUST be accompanied by unit or integration tests. Our test framework is [Jest/Vitest/Pytest]. Run tests using `[npm test / poetry run pytest]`.
- **Linting:** All code MUST pass the linter. Run `npm run lint` or `poetry run ruff check .` before committing.
- **Commits:** All commit messages MUST follow the Conventional Commits specification.
- **Packages:** Run `npm outdated` before adding new packages to check for necessary updates.
- **Security:** No secrets in the codebase. All secrets are managed via GitHub Actions Secrets and exposed as environment variables.

## 3. Key Project-Specific Documentation
To understand this project, you MUST reference these files. They are the source of truth.
- `docs/architecture.md`: High-level system architecture.
- `docs/technical.md`: Core technical decisions and patterns.
- `[src/lib/core.ts]`: [Example of a critical file the AI should know well.]

## 4. Workflow for Features
1.  **Plan:** First, outline the files you will create or modify.
2.  **Code & Test:** Write the code and the corresponding tests.
3.  **Run Tests:** Execute the test command (`[npm test]`) and ensure all pass.
4.  **Lint:** Run the linter (`[npm run lint]`) and fix all issues.
5.  **Notify:** Inform me when you are done.