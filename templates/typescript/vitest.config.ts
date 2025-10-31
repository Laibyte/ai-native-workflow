import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    // Use global test APIs (describe, it, expect)
    globals: true,
    
    // Test environment
    environment: 'node',
    
    // Coverage configuration
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html', 'lcov'],
      exclude: [
        'node_modules/',
        'dist/',
        '**/*.test.ts',
        '**/*.spec.ts',
        '**/types/',
        '**/*.config.ts',
      ],
      thresholds: {
        lines: 80,
        functions: 80,
        branches: 80,
        statements: 80,
      },
    },
    
    // Watch mode options
    watch: false, // Disable watch by default (use --watch flag)
    
    // Test timeout
    testTimeout: 10000,
    
    // Include/exclude patterns
    include: ['src/**/*.{test,spec}.ts'],
    exclude: ['node_modules', 'dist'],
  },
});
