/**
 * Example function that adds two numbers
 * @param a - First number
 * @param b - Second number
 * @returns Sum of a and b
 * @example
 * ```typescript
 * const result = add(2, 3);
 * console.log(result); // 5
 * ```
 */
export function add(a: number, b: number): number {
  return a + b;
}

/**
 * Example async function that fetches data
 * @param url - URL to fetch from
 * @returns Promise that resolves to the response data
 * @throws {Error} If the request fails
 */
export async function fetchData<T>(url: string): Promise<T> {
  try {
    const response = await fetch(url);
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    const data = (await response.json()) as T;
    return data;
  } catch (error) {
    if (error instanceof Error) {
      console.error('Failed to fetch data:', error.message);
    }
    throw error;
  }
}

/**
 * Result type for operations that can fail
 */
export type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E };

/**
 * Example function demonstrating Result pattern
 * @param value - Number to parse
 * @returns Result with parsed number or error
 */
export function parseNumber(value: string): Result<number> {
  const parsed = Number(value);
  
  if (isNaN(parsed)) {
    return {
      success: false,
      error: new Error(`Invalid number: ${value}`),
    };
  }
  
  return {
    success: true,
    data: parsed,
  };
}
