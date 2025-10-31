import { describe, it, expect } from 'vitest';
import { add, parseNumber, type Result } from '../index';

describe('add', () => {
  it('should add two positive numbers', () => {
    expect(add(2, 3)).toBe(5);
  });

  it('should add negative numbers', () => {
    expect(add(-2, -3)).toBe(-5);
  });

  it('should add positive and negative numbers', () => {
    expect(add(5, -3)).toBe(2);
  });

  it('should handle zero', () => {
    expect(add(0, 5)).toBe(5);
    expect(add(5, 0)).toBe(5);
  });

  it('should handle decimal numbers', () => {
    expect(add(1.5, 2.3)).toBeCloseTo(3.8);
  });
});

describe('parseNumber', () => {
  it('should parse valid integer string', () => {
    const result = parseNumber('42');
    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data).toBe(42);
    }
  });

  it('should parse valid decimal string', () => {
    const result = parseNumber('3.14');
    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data).toBeCloseTo(3.14);
    }
  });

  it('should parse negative number string', () => {
    const result = parseNumber('-10');
    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data).toBe(-10);
    }
  });

  it('should return error for invalid string', () => {
    const result = parseNumber('not a number');
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(result.error).toBeInstanceOf(Error);
      expect(result.error.message).toContain('Invalid number');
    }
  });

  it('should return error for empty string', () => {
    const result = parseNumber('');
    expect(result.success).toBe(false);
  });

  it('should handle scientific notation', () => {
    const result = parseNumber('1e3');
    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data).toBe(1000);
    }
  });
});
