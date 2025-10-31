# TypeScript/JavaScript Project Template

Production-ready TypeScript project template with testing, linting, and CI/CD.

## Features

- ✅ TypeScript in strict mode
- ✅ Vitest for unit tests
- ✅ ESLint + TypeScript-ESLint for linting
- ✅ Prettier for formatting
- ✅ Husky for pre-commit hooks
- ✅ GitHub Actions CI/CD
- ✅ npm package management (no Yarn/pnpm)
- ✅ Conventional commits enforced
- ✅ AI-native with Cursor rules

## Quick Start

```bash
# Create new project from template
npx degit path/to/templates/typescript my-project
cd my-project

# Install dependencies
npm install

# Run tests in watch mode
npm run test:watch

# Run linting
npm run lint

# Build
npm run build
```

## Project Structure

```
my-project/
├── .cursorrules           # Cursor AI rules
├── .github/
│   └── workflows/
│       └── ci.yml         # GitHub Actions CI
├── .husky/                # Git hooks
│   ├── pre-commit
│   └── commit-msg
├── src/
│   ├── index.ts           # Entry point
│   └── __tests__/         # Test files
│       └── index.test.ts
├── dist/                  # Build output (gitignored)
├── .eslintrc.json         # ESLint config
├── .prettierrc.json       # Prettier config
├── tsconfig.json          # TypeScript config
├── vitest.config.ts       # Vitest config
├── package.json
└── README.md
```

## Scripts

- `npm run dev` - Run in development mode with watch
- `npm run build` - Build for production
- `npm run test` - Run tests once
- `npm run test:watch` - Run tests in watch mode
- `npm run test:coverage` - Run tests with coverage
- `npm run lint` - Check linting
- `npm run lint:fix` - Fix linting issues
- `npm run format` - Check formatting
- `npm run format:fix` - Fix formatting issues
- `npm run typecheck` - Run TypeScript type checking
- `npm run clean` - Clean build artifacts

## Configuration

### TypeScript

TypeScript is configured in strict mode with modern ES modules:

```json
{
  "compilerOptions": {
    "strict": true,
    "target": "ES2022",
    "module": "ES2022",
    "moduleResolution": "bundler"
  }
}
```

### Testing

Vitest is configured for fast, modern testing:

```typescript
export default defineConfig({
  test: {
    globals: true,
    environment: 'node',
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      thresholds: {
        lines: 80,
        functions: 80,
        branches: 80,
        statements: 80
      }
    }
  }
});
```

### Linting

ESLint with TypeScript support and recommended rules:

```json
{
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:@typescript-eslint/recommended-requiring-type-checking",
    "prettier"
  ]
}
```

### Pre-commit Hooks

Husky ensures quality before commits:

- **pre-commit**: Lint and format changed files
- **commit-msg**: Validate conventional commit format

## CI/CD

GitHub Actions workflow runs on every push and PR:

1. Install dependencies
2. Run linting
3. Run type checking
4. Run tests with coverage
5. Build project

## AI Integration

This template includes Cursor rules that ensure:

- Tests always run after code changes
- npm is used exclusively (no Yarn/pnpm)
- Linting and formatting pass before commits
- Documentation stays up to date
- Conventional commits are followed

## Customization

### Package Name and Description

Update `package.json`:

```json
{
  "name": "your-package-name",
  "description": "Your package description",
  "version": "0.1.0",
  "author": "Your Name"
}
```

### Add Dependencies

```bash
# Add runtime dependency
npm install package-name

# Add dev dependency
npm install -D package-name
```

### Environment Variables

Create `.env` file (gitignored by default):

```
NODE_ENV=development
LOG_LEVEL=debug
```

Load with a package like `dotenv`:

```typescript
import 'dotenv/config';

const logLevel = process.env.LOG_LEVEL || 'info';
```

## Best Practices

### File Organization

- Keep source files in `src/`
- Colocate tests with source: `__tests__/` folders or `.test.ts` suffix
- Use barrel exports for public API: `src/index.ts`
- Separate types: `src/types/` for shared types

### Testing

- Write tests for all public APIs
- Aim for >80% coverage
- Use descriptive test names
- Group related tests with `describe`
- Mock external dependencies

### Error Handling

```typescript
// Use custom error classes
export class ValidationError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'ValidationError';
  }
}

// Return results with explicit errors
type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E };
```

### Logging

```typescript
// Use structured logging
import pino from 'pino';

const logger = pino({
  level: process.env.LOG_LEVEL || 'info'
});

logger.info({ userId: '123' }, 'User logged in');
logger.error({ error: err }, 'Failed to process');
```

## Troubleshooting

### Tests Not Running

```bash
# Clear caches
npm run clean
npm install
```

### Linting Errors

```bash
# Auto-fix what can be fixed
npm run lint:fix
npm run format:fix
```

### Type Errors

```bash
# Run type checking
npm run typecheck

# Check specific file
npx tsc --noEmit src/file.ts
```

## License

MIT
