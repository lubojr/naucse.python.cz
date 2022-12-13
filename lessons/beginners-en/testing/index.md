# Testing

Programming is not just about writing code. 
It is important to verify that the code does what it should 
(and about fixing it if needed).
The process of verification that the program works as expected is called *testing*.

You have probably already tested your programs by executing them.
When you test your program, you usually enter some input data and look if
the result is correct.
This is okay for a small program, but it gets harder as the program gets bigger.
Bigger programs have more options what they can do based on the possible
user input and configuration. Their manual testing becomes time-consuming,
especially when it needs to be repeated after every change, and it becomes more
likely errors slip unnoticed into our code.

Humans are not very good at performing boring repetitive tasks, that is
the domain of computers. And, not surprisingly, that is the reason why
developers write the code that verifies their programs.

*Automated tests* are functions checking, with no manual intervention,
that all features of the tested program work correctly.
If made right, the tests should be lean and give quick response whether
the program has issues or not. The testing does not give us 100% proof that
the code is without errors but it is still better than no testing at all.

The automated tests make modification of the code easier as you can
faster find possible bugs in the existing functionality (aka *regressions*).


## Installing the pytest library

Up to now, we have used only the modules that come installed with Python, 
for example, modules such as `math` or `turtle`.
There are many more *libraries* that are not included in Python
but you can install them to your Python environment and use them.

The library for testing in Python is called `unittest`.
It is quite difficult to use this library so we will use a better one.
We will install the library `pytest` which is faster, easier to use and very popular.

Submit the following command. (It is a command-line command, 
just as `cd` or `mkdir`; do not enter it into the Python console.)

```console
$ python3 -m pip install pytest
```

> [note] What is pip and why do we use it?
> `pip` is a Python command-line tool for installing 3rd-party
> Python libraries from the [Python Package Index (PyPI)](https://pypi.org)
> and other sources (e.g., Git repositories).
>
> `python3 -m pip install pytest` makes Python to install `pytest` library from PyPI.
>
> For help on how to use pip run `python3 -m pip --help`.

> [note] python3 -m &lt;command&gt; or just &lt;command&gt;
> `python3 -m <command>` tells Python to execute a script from the
> Python module named `<command>` (e.g., `python3 -m pip ...`).
> In a properly configured Python environment, it should be possible to call
> the `<command>` directly, without the help of the `python` command
> (e.g., `pip ...`)
>
> To save ourselves the trouble of unnecessary complications with a possibly
> misconfigured Python environment we recommend using the longer
> `python3 -m <command>` version.


## Writing tests

We will show testing through a very simple example.
There is a function `add` that can add two numbers.
There is another function that tests if the 
`add` function returns correct results for specific numbers.

Make a copy of the code into a file named `test_addition.py`
in a new empty directory.

The naming of files and test functions is important for `pytest` (with default settings). 
It is important for names of files containing tests and test functions
to start with `test_`.

```python
def add(a, b):
    return a + b

def test_add():
    assert add(1, 2) == 3
```

> [note] The naming of files and test functions matters
> `pytest` scans your code and
> searches for the included tests. When found, these tests are executed.
>
> By default, the names of the test files and the test functions must start with
> the `test_` prefix in order to be recognized as tests.


What does the test function do?

The `assert` statement evaluates the expression that follows it.
If the result is not true then it raises the `AssertionError` exception 
which is interpreted by `pytest` as a failing test.
You can imagine that `assert a == b` does following:

```python
if not (a == b):
    raise AssertionError
```

> [note]
> Do not use `assert` outside of test functions for now.
> For "regular" code, the  `assert` has functionality that
> we will not explain now.


## Running tests

You execute tests with the command `python -m pytest -v <path>`
followed by the path to the file containing the tests.

> [note]
> You can omit the `<filename>` argument and then `python -m pytest -v`
> scans the current directory and runs tests in all files whose names start
> with the `test_` prefix.
>
> You can also use a path to a directory where `pytest` should searches for
> the tests.

This command scans the given file and calls all functions that start
with the `test_` prefix. It executes them and checks if they raise any exception,
e.g., raised by the `assert` statement.

```ansi
$ python3 -m pytest -v test_addition.py
␛[1m============================= test session starts ==============================␛[0m
platform linux -- Python 3.8.3, pytest-7.1.2, pluggy-1.0.0
rootdir: /tmp/test_example
collected 1 item

test_addition.py ␛[32m.␛[0m␛[32m                                                       [100%]␛[0m

␛[32m============================== ␛[32m␛[1m1 passed␛[0m␛[32m in 0.00s␛[0m␛[32m ===============================␛[0m
```
If an exception occurs, `pytest` shows a red message with
additional details that can help you find the bug and fix it:

```ansi
␛[1m============================= test session starts ==============================␛[0m
platform linux -- Python 3.8.3, pytest-7.1.2, pluggy-1.0.0
rootdir: /tmp/test_example
collected 1 item

test_addition.py ␛[31mF␛[0m␛[31m                                                       [100%]␛[0m

=================================== FAILURES ===================================
␛[31m␛[1m___________________________________ test_add ___________________________________␛[0m

    def test_add():
>       assert add(1, 2) == 3
␛[1m␛[31mE       assert 4 == 3␛[0m
␛[1m␛[31mE        +  where 4 = add(1, 2)␛[0m

␛[1m␛[31mtest_addition.py␛[0m:5: AssertionError
=========================== short test summary info ============================
FAILED test_addition.py::test_add - assert 4 == 3
␛[31m============================== ␛[31m␛[1m1 failed␛[0m␛[31m in 0.01s␛[0m␛[31m ===============================␛[0m
```

Try to run the test yourself. Modify the `add` function or (its test) so that the
test fails.

## Test modules

You do not usually write tests in the same file with the regular code.
Typically, you write tests in another file.
This way, your code is easier to read, and it makes it possible to distribute 
only the code, without the tests, to someone who is interested only in executing the program.

Split the `test_addition.py` file: Move the `add` function to a new module `addition.py`.
In the `test_addition.py` file, keep only the test.
To the `test_addition.py` file, add `from addition import add` to the top
so the test can call the tested function.

The test should pass again.

Let's now try to add two different tests for a function for computing perimeter of
rectangle from [custom functions]({{ lesson_url('beginners-en/functions') }})

```python
def find_perimeter(width, height): 
    "Returns the rectangle's perimeter of the given sides" 
    return  2 * (width  +  height)
```

{% filter solution %}

Possible tests examples:

```python
def test_find_perimeter_1():
    """ Tests if the function can handle two positive integer values as input.
    """
    res = find_perimeter(4, 5)
    assert res == 18

def test_find_rectangle_perimeter_zero_width():
    """ Tests if the function can handle width set to 0.
    """
    res = find_perimeter(0, 3)
    assert res == 0
```

{% endfilter %}

## Executable modules

Automated tests have to be able to run unattended. They are often executed
automatically and the failures are reported via some sort of notification,
e.g., by email.

In practical terms, this means that the tests must not depend on live
interaction with the user, e.g., the `input` function will not work in tests.

> [note] Can we test user interaction in automated tests?
> There are testing techniques allowing us to emulate user interaction
> in the user interfaces. But is that beyond the scope of this course.

This can make your work harder sometimes. Let's look at a more complex project,
the 1D (one-dimensional) tic-tac-toe.

> [note]
> If you do not have the 1D tic-tac-toe program, the following sections are
> only theoretical.
>
> If you study at home, complete the 1D tic-tac-toe lesson before continuing.
> The task description is at [one-dimensional tic-tac-toe](../tictactoe))..

The structure of the 1D tic-tac-toe code looks roughly like this:

```python
import random  # (and possibly other import statements that are needed)

def move(board, space_number, mark):
    """Returns the board with the specified mark placed in the specified position"""
    ...

def player_move(board):
    """Asks the player what move should be done and returns the board
    with the move played.
    """
    ...
    input('What is your move? ')
    ...

def tic_tac_toe_1d():
    """Starts the game

    It creates an empty board and runs player_move and computer_move alternately
    until the game is finished.
    """
    while ...:
        ...
        player_move(...)
        ...

# Start the game:
tic_tac_toe_1d()
```

If you import this module, Python executes all commands in it, from top to bottom:

- The first command, `import`, initializes the variables and functions of the
  `random` module. It is module from the standard Python library it is unlikely
  that it would have any side effect to worry about.

- The definitions of functions (`def` statements and everything in them)
  just define the functions but they do not execute them.

- Calling the `tic_tac_toe_1d` function starts the game.
  The `tic_tac_toe_1d` calls the `player_move()` function which calls `input()`.
  This is an issue.

If you import this module to the tests, the `input` fails and the module does
not get not imported.

> [note]
> If you want to import such a module from elsewhere, e.g., you would like
> to use `move()` in a different game, the import of the module itself will
> start the 1D tic-tac-toe game!

The calling of `tic_tac_toe_1d` is a side-effect and we need to remove it.
Okay, but you cannot start the game without it! What can we do about it?

We can create a new python file, e.g., `game.py` and we move the
`tic_tac_toe_1d()` call in it:

```python
import tic_tac_toe

tic_tac_toe.tic_tac_toe_1d()
```

You cannot test this module because it calls `input` indirectly.
But you can execute it if you want to play.
Since you do not have tests for this module, it should be very simple: 
one import and one statement.

You can import the original module from tests or other modules.

A test for the original module could look like this:

```python
import tic_tac_toe

def test_move_to_empty_space():
    board = tic_tac_toe.computer_move('--------------------')
    assert len(board) == 20
    assert board.count('x') == 1
    assert board.count('-') == 19
```

## Positive and negative tests

Tests that verify that a program works correctly
under correct conditions are called *positive tests*.
An exception raised during the positive testing lead to failure of the test.

Tests that check behaviour in case of invalid inputs are called *negative tests*.
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
