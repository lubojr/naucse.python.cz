# Exceptions

We have already talked about [error messages]({{ lesson_url('beginners-en/print') }}).
When an error occurs, Python complains, tells us where the error (line) is,
and terminates the program.  But there is much more that we can learn about
error messages (aka *exceptions*).


## Printing errors:

Let's start with an example (`example.py`):

```python
def outer_function():
    return innner_function(0)

def inner_function(divisor):
    return 1 / divisor

print(outer_function()
```

When we run the code it stops with an error and a message like:

<!-- XXX: Highlight the line numbers -->
```pycon
Traceback (most recent call last):
  File "example.py", line 7, in <module>
    print(outer_function())
  File "example.py", line 2, in outer_function
    return inner_function(0)
  File "example.py", line 5, in inner_function
    return 1 / divisor
ZeroDivisionError: division by zero
```

Note that every function call that led to the error is listed here.
The actual error is probably somewhere near that function call.
In our case the error is obvious. `1` cannot be divided by `0`.

To avoid the error we could either not call `inner_function` with argument `0`
or write the `inner_function` so that it handles the case the `0` divisor.
But Python does not know what the right solution is.
During the execution, it simply reaches an error state where it cannot continue
and gives up with a nice report where the error happened (we call this
report a *stack trace*).

This situation is called an *exception*. When Python reaches an error state
it *raises* an exception object (`ZeroDivisionError` in our case).
This exception is propagated up through the stack of the called functions and,
if not caught, it eventual kills the running script.


## Raising an exception

In Python, an *exception* is raised by the command `raise`.
The command is followed by the name of the exception we want to raise and
an optional short description of what went wrong (in parentheses).

```python
MAX_ALLOWED_VALUE = 20

def verify_number(number):
    if number < 0 or number >= < MAX_ALLOWED_VALUE:
        raise ValueError(f"The number {number} is not in the allowed range!")
    print(f"The number {number} is OK!")

verify_number(5)
verify_number(25)
```

When we run the script, we get the following output:
```pycon
The number 5 is OK!
Traceback (most recent call last):
  File "example.py", line 9, in <module>
    verify_number(25)
  File "example.py", line 5, in verify_number
    raise ValueError(f"The number {number} is not in the allowed range!")
ValueError: The number 25 is not in the allowed range!
```

What exceptions are available in Python?
Python provides a hierarchy of standard (built-in) exceptions. This
is just a subset of them:

```plain
BaseException
 ├── SystemExit                     raised by function exit()
 ├── KeyboardInterrupt              raised after pressing Ctrl+C
 ╰── Exception
      ├── ArithmeticError
      │    ╰── ZeroDivisionError    zero division
      ├── AssertionError            command `assert` failed
      ├── AttributeError            non-existing attribute, e.g. 'abc'.len
      ├── ImportError               failed import
      ├── LookupError
      │    ├── IndexError           non-existing index, e.g. 'abc'[999]
      │    ╰── KeyError             non-existing dictionary key
      ├── NameError                 used a non-existing variable name
      │    ╰── UnboundLocalError    used a variable that wasn't initiated
      ├── OSError
      │    ╰── FileNotFoundError    requested file does not exist
      ├── SyntaxError               wrong syntax – program is unreadable/unusable
      │    ╰── IndentationError     wrong indentation
      │         ╰── TabError        combination of tabs and spaces
      ├── TypeError                 wrong type, e.g. "a" + 1
      ╰── ValueError                wrong value, e.g. int('xyz')
```

For the full list of built-in exception see the [Python documentation](https://docs.python.org/3/library/exceptions.html).

> [note] What does this hierarchy mean?
>
> The hierarchy of exceptions is like a family tree with the most generic type
> of exception as the root, every branch becoming more specific.
> E.g., `KeyError` is also a `LookupError` and `Exception` but it is
> not, e.g., a `SyntaxError`.
>
> You will learn more about these hierarchies and when we will talk about
> the Object Oriented Programming, classes and inheritance.
>
> For the moment, it is enough to say that the exceptions are **classes** and
> that the more specific **child** exceptions **inherit** the properties
> of their generic generic **parent**.  Namely, the `Exception` is the parent
> class of the `LookupError` and the `LookupError` is the parent classes of the
> `KeyError` exception. Therefore the `KeyError` has properties
> of `LookupError` and `Exception` exceptions.


## Custom exceptions

> [note]
> There will be a whole session dedicated to classes and we will no explain
> the syntax in detail here.

This is an example of a custom exception called `PyLadiesException` derived from
the `Exception`.

```ansi
BaseException
 ╰── Exception
      ╰── ␛[32mPyLadiesException␛[0m
```

The code is fairly simple:

```python
class PyLadiesException(Exception):
    """ PyLadies private exception. """

raise PyLadiesException("My first PyLadies exception!")
```

Try it and you will see that your new exception behaves just like any other
exception:

```pycon
Traceback (most recent call last):
  File "exception.py", line 5, in <module>
    raise PyLadiesException("My first PyLadies exception!")
__main__.PyLadiesException: My first PyLadies exception!
```

> [note]
> We strongly recommend that you always inherit your private exceptions from
> the `Exceptions` class or its descendants so that it can be caught as an
> actual `Exception`.


## Handling Exceptions

Why there are so many built-in exceptions? Because this way we can more easily
*catch* exceptions of specific error states.

It is not always desired that an exception kills our program. And we also cannot
(or do not want to) cover all possible error conditions in the code
where the exceptions are raised from.

What we often do is that we let the exceptions to be raised in the low-level
code and catch them higher in the call stack.

Let me show you an example:

```python
def prompt_number():
    answer = input('Enter some number: ')
    if not answer:
        return None
    try:
        number = int(answer)
    except ValueError:
        print('That is not a number! I will continue with 0')
        number = 0
    return number

print("Press ENTER to stop the script.")
while True:
    number = prompt_number()
    if number is None:
        break
    print(f"Entered number: {number}")
```

Run the code and try different inputs. What happens if the input is not
an integer number?

Invalid input does not cause an error, instead it gets replaced by `0`.

So how does this work?

We call the `int()` function within the `try` block.
If there is no error, this function is executed, it returns a value which
is assigned to the `number` variable and leaves the `try` block.

In case of a `ValueError` exception raised by `int()` caused by an invalid input
value, this exception is caught and the execution continues
in the `except ValueError` block. There, a message is printed and
`0` is assigned to the `number` variable.

In this case we specifically catch the `ValueError` exception.
We could achieve the same by catching generic `Exception`, because, as you can
see in the hierarchy above, `ValueError` is a specific type of `Exception`.


### Don't catch'em all!

Try to be as selective as possible when catching the expected exceptions.
There is no need to catch the most of the errors.

> [note]
> When an unexpected error happens it is **much better** to terminate the program
> rather than to continue with wrong values.
> When an unexpected error happens we want to know about it as soon as it
> appears. With the wrong values bad things will happen later in the code anyway
> and the real cause will be **difficult** to trace.

For example, catching the exception `KeyboardInterrupt`
could have the side effect that the program couldn't be terminated if we needed to
(with shortcut <kbd>Ctrl</kbd>+<kbd>C</kbd>).

Use the command `try/except` only in situations when you
anticipate some exception, i.e., you know exactly what can happen
and why, and you are able to fix the error state in the except block.

A typical example would be reading the input from a user. If the user
enters gibberish, it is better to ask again until the
user enters something meaningful:


```pycon
>>> def fetch_number():
...     while True:
...         answer = input("Type a number: ")
...         try:
...             return int(answer)
...         except ValueError:
...             print("Oi! This is rubbish, mate! Do it again!")
>>> fetch_number()
Type a number: nan
Oi! This is trash, mate! Do it again!
Type a number: 42
42
```


## Other clauses

Additionally to `except`, there are two more clauses (blocks that can
be used with `try`) and these are `else` and `finally`.

The first, `else`, will be run if no exception in the `try` block was raised.
Use this clause to perform actions which require successful execution
of the `try` block but outside of it, e.g., to run code which
might raise unwanted exception interfering with the `except` clauses.

The latter, `finally`, runs every time regardless of what happens in the `try`
block.  The `finally` block is executed even in the case of an uncaught exception
and may be used even without any `except` clause.
It is mostly used for clean-ups:

```python
try:
    # do something with an allocated resource
finally:
    # release the allocaded resource regardless of the 'try' result
```

You can also have multiple `except` blocks. Only one of them will be executed --
the first one that can handle the raised exception.

> [note]
> Always catch more specific exceptions before the generic ones.

```python
try:
    do_something()
except ValueError:
    print("This will be printed if there's a ValueError.")
except NameError:
    print("This will be printed if there's a NameError.")
except Exception:
    print("This will be printed if there's some other exception.")
    # (apart from SystemExit a KeyboardInterrupt, we don't want to catch those)
except TypeError:
    print("This will never be printed")
    # ("except Exception" above already caught the TypeError)
else:
    print("This will be printed if there's no error in try block")
finally:
    print("This will always be printed; even if there's e.g. a 'return' in the 'try' block.")
```

## Assertions

Let's briefly talk about the *assertions* and the Python `assert` statement:

```python
assert <condition>

```

The assertions are used to check that certain conditions (*assumptions*) in your
code are fulfilled. To do so you can put the Python `assert` command followed
by a logical condition (aka *predicte*). If the condition is not met
Python will raise the `AssertionError` exception. The `assert <condition>`
statement is equivalent to:

``` python
if not <condition>:
    raise AssertionError
```

E.g., let's see this code to calculate the perimeter and area of a square:

```python
def input_side():
    return float(input("Enter the side of a square in centimeters: "))

def get_square_perimeter(side):
    return 4 * side

def get_square_area(side):
    return side ** 2

def main():
    side = input_side()
    perimeter = get_square_perimeter(side)
    area = get_square_area(side)

    print(f"The perimeter of a square with a side of {side} cm is {perimeter} cm.")
    print(f"The area of a square with a side of {side} cm is {area} cm2.")

if __name__ == "__main__":
    main()
```

The perimeter and are calculation does work only if the side of the sqare
is not negative (`side >= 0`), we want to **assert that the side is
a non-negative number**. We do it by inserting the `assert` commands:

```python
def get_square_perimeter(side):
    assert side >= 0
    return 4 * side

def get_square_area(side):
    assert side >= 0
    return side ** 2
```

Now when we run the code and enter negative number for the side,
the program ends with the `AssertionError` error:

```pycon
Traceback (most recent call last):
  File "square.py", line 21, in <module>
    main()
  File "square.py", line 14, in main
    perimeter = get_square_perimeter(side)
  File "square.py", line 5, in get_square_perimeter
    assert side >= 0
AssertionError
```

Assertions are meant to help us to debug the code. By putting the assertions
in your code you are telling to Python (and also to other readers of your code)
that certain condition must be satisfied in order to make your code work
correctly.

The assertions however do not replace proper error checking (e.g., a proper
input value check in our case; see next section):

> [note] Python can disable assertions
>
> Assertions are debugging features and make the execution slower.
> When executed with the performance optimized mode (`python -O ...`),
> Python disables the assertions.
>
> Therefore the assertions do not replace proper checks in your code.

## Task

Let's add exception handling and proper input checking to our square size
calculator. Modify the code so that if the user does not enter a non-negative
number the programs prompts the input again.

{% filter solution %}

Possible solution for the calculator:

```python
def input_side():
    while True:
        raw_input = input("Enter the side of a square in centimeters: ")
        try:
            side = float(raw_input)
        except ValueError:
            print(f"{raw_input} is not a number!")
        else:
            if side < 0:
                print(f"{raw_input} is a negative number!")
            else:
                break
    return side

def get_square_perimeter(side):
    assert side >= 0
    return 4 * side

def get_square_area(side):
    assert side >= 0
    return side ** 2

def main():
    side = input_side()
    perimeter = get_square_perimeter(side)
    area = get_square_area(side)

    print(f"The perimeter of a square with a side of {side} cm is {perimeter} cm.")
    print(f"The area of a square with a side of {side} cm is {area} cm2.")

if __name__ == "__main__":
    main()
```

{% endfilter %}
