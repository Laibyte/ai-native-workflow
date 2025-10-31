"""Tests for main module."""

import pytest

from python_project.main import add, divide, greet


class TestAdd:
    """Tests for add function."""

    def test_add_positive_numbers(self) -> None:
        """Test adding two positive numbers."""
        assert add(2, 3) == 5

    def test_add_negative_numbers(self) -> None:
        """Test adding two negative numbers."""
        assert add(-2, -3) == -5

    def test_add_mixed_numbers(self) -> None:
        """Test adding positive and negative numbers."""
        assert add(5, -3) == 2

    def test_add_zero(self) -> None:
        """Test adding zero."""
        assert add(0, 5) == 5
        assert add(5, 0) == 5

    def test_add_with_fixture(self, sample_numbers: tuple[int, int]) -> None:
        """Test add using fixture."""
        a, b = sample_numbers
        assert add(a, b) == 15


class TestDivide:
    """Tests for divide function."""

    def test_divide_normal(self) -> None:
        """Test normal division."""
        result = divide(10, 2)
        assert result is not None
        assert result == 5.0

    def test_divide_by_zero(self) -> None:
        """Test division by zero returns None."""
        assert divide(10, 0) is None

    def test_divide_negative(self) -> None:
        """Test division with negative numbers."""
        result = divide(-10, 2)
        assert result is not None
        assert result == -5.0

    def test_divide_decimal(self) -> None:
        """Test division resulting in decimal."""
        result = divide(10, 3)
        assert result is not None
        assert abs(result - 3.333333) < 0.00001

    @pytest.mark.parametrize(
        "a,b,expected",
        [
            (10, 2, 5.0),
            (20, 4, 5.0),
            (15, 3, 5.0),
            (100, 20, 5.0),
        ],
    )
    def test_divide_parametrized(self, a: float, b: float, expected: float) -> None:
        """Test divide with multiple parameter sets."""
        result = divide(a, b)
        assert result is not None
        assert result == expected


class TestGreet:
    """Tests for greet function."""

    def test_greet_informal(self) -> None:
        """Test informal greeting."""
        assert greet("World") == "Hello, World!"

    def test_greet_formal(self) -> None:
        """Test formal greeting."""
        assert greet("Dr. Smith", formal=True) == "Good day, Dr. Smith!"

    def test_greet_empty_name(self) -> None:
        """Test greeting with empty name."""
        assert greet("") == "Hello, !"

    def test_greet_with_fixture(self, sample_name: str) -> None:
        """Test greet using fixture."""
        result = greet(sample_name)
        assert "Test User" in result
        assert result.startswith("Hello")

    @pytest.mark.parametrize(
        "name,formal,expected",
        [
            ("Alice", False, "Hello, Alice!"),
            ("Bob", True, "Good day, Bob!"),
            ("Charlie", False, "Hello, Charlie!"),
        ],
    )
    def test_greet_parametrized(self, name: str, formal: bool, expected: str) -> None:
        """Test greet with multiple parameter sets."""
        assert greet(name, formal=formal) == expected
