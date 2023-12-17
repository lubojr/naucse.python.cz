## Negative tests

Tests that verify that a program works correctly
under correct conditions are called *positive tests*.
An exception raised during the positive testing lead to failure of the test.

Tests which check behaviour for invalid inputs are called *negative tests*.
The purpose of the negative testing is verification of the graceful handling
of error states. Raising of an exception is often the expected behaviour
of the tested code.

For example, the `computer_move` function should raise an error
(e.g., `ValueError`) when the board is full.

> [note]
> It is much better to raise an exception than doing nothing
> and silently letting the program get stuck elsewhere.
> You can use such function in a more complex program
> and be sure that it will raise an understandable error
> when it is called under bad conditions.
> The error helps you to fix the actual problem. The sooner you discover
> an error the easier is to fix it.

Use the `with` statement and the `raises` function 
to test that your code raises the expected exception.
The `raises` function is imported from the `pytest` module.


> [note]
> We have not talked about the `with` statement and context managers yet.
> But don't worry, you will learn about them later.  Just check how it is used
> to test whether an exception is raised.

```python
import pytest

import tic_tac_toe

def test_move_failure():
    with pytest.raises(ValueError):
        tic_tac_toe.computer_move('oxoxoxoxoxoxoxoxoxox')
```

Let's now try to edit the function for getting a perimeter of rectangle
so that it raises a ValueError if any of the sides is smaller or equal to zero.
Add a test for the new functionality.


{% filter solution %}

```python
import pytest

def find_rectangle_perimeter(width, height):
    """ Calculate perimeter of a rectangle from the given sides.
    """
    if width < 0 or height < 0:
        raise ValueError("Rectangle sides must be non-negative.")
    return  2 * (width + height)

def test_find_perimeter_exception_negative():
    """ Tests of negative integer values as input
    """
    with pytest.raises(ValueError):
        find_rectangle_perimeter(-3, 5)
```
{% endfilter %}

## Pytest fixtures

``Fixtures`` in pytest are reusable components that set up specific states (e.g. database connections, test data).

### Key Features

- Reusability: Define a fixture once and use it across multiple test functions.
- Scoping: Fixtures can be scoped (available) at different levels like function, class, module, or session.
- Automatic Cleanup: Fixtures can be set up to automatically clean up resources after a test is done.
- Dependency Injection: Test functions can use fixtures by including them as arguments. (It is not possible to add "normal" arguments to test functions, only references to fixtures).

You can easily create and use a ``fixture in pytest`` in a following way:

```python
import pytest

@pytest.fixture
def sample_data():
    return [1, 2, 3, 4]
def test_sum(sample_data):
    assert sum(sample_data) == 10
```

By default ``fixture`` is called once per a test function - ``scope=function`` parameter of a fixture.

For resource utilization purposes it could be useful to create a fixture only once per whole ``module``:

```python
import pytest
# A fixture to provide a configuration dictionary
@pytest.fixture(scope="module")
def config_data():
    config = {
        "api_endpoint": "http://api.example.com",
        "retry_attempts": 5,
        "timeout": 10
    }
    return config
# Example test using the fixture
def test_api_endpoint(config_data):
    assert config_data["api_endpoint"] == "http://api.example.com"
# Another test using the same fixture
def test_retry_attempts(config_data):
    assert config_data["retry_attempts"] == 5
```

This approach is useful when the setup does not involve external resources that require explicit cleanup after the tests.
