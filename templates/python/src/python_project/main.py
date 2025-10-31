"""Main module with example functions."""

from typing import Optional


def add(a: int, b: int) -> int:
    """Add two numbers.

    Args:
        a: First number
        b: Second number

    Returns:
        Sum of a and b

    Examples:
        >>> add(2, 3)
        5
        >>> add(-1, 1)
        0
    """
    return a + b


def divide(a: float, b: float) -> Optional[float]:
    """Divide two numbers.

    Args:
        a: Numerator
        b: Denominator

    Returns:
        Result of a / b, or None if b is zero

    Examples:
        >>> divide(10, 2)
        5.0
        >>> divide(10, 0) is None
        True
    """
    if b == 0:
        return None
    return a / b


def greet(name: str, formal: bool = False) -> str:
    """Generate a greeting message.

    Args:
        name: Name of the person to greet
        formal: Whether to use formal greeting

    Returns:
        Greeting message

    Examples:
        >>> greet("World")
        'Hello, World!'
        >>> greet("Dr. Smith", formal=True)
        'Good day, Dr. Smith!'
    """
    if formal:
        return f"Good day, {name}!"
    return f"Hello, {name}!"


def main() -> None:
    """Main entry point."""
    print(greet("World"))
    print(f"2 + 3 = {add(2, 3)}")
    result = divide(10, 2)
    if result is not None:
        print(f"10 / 2 = {result}")


if __name__ == "__main__":
    main()
