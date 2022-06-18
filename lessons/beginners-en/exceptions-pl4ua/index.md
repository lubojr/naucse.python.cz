# Exceptions

We have already talked about [error messages]({{ lesson_url('beginners-en/print') }}),
Python complains, tells us where the error (line) is, and terminates the program.
But there is much more that we can learn about error messages (aka *exceptions*).


## Printing errors:

Let's start by an example (`example.py`):

```python
def outer_fucntion():
    return innner_function(0)

def inner_function(divisor):
    return 1 / divisor

print(outer_fucntion()
```

When we run the code it stops with an error and message like:

<!-- XXX: Highlight the line numbers -->
```pycon
Traceback (most recent call last):
  File "example.py", line 7, in <module>
    print(outer_fucntion())
  File "example.py", line 2, in outer_fucntion
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
report a `stack trace`).

This behaviour is called an *exception*. When Python reaches an error state
it *raises* an exception (`ZeroDivisionError` in our case).
This exception is propagated up trough the stack of the calling function and,
if not caught, it eventual kills the running script.


## Raising an exception

In Python, an *exception* is by the command `raise`.
The command is followed by the name of the exception we want to raise and
a short description of what went wrong (in parentheses).

```python
MAX_ALLOWED_VALUE = 20

def verify_number(number):
    if number < 0 or number >= < MAX_ALLOWED_VALUE:
        raise ValueError(f"The number {number} is not in the allowed range!")
    print(f"The number {number} is OK!")

verify_number(5)
verify_number(25)
```

When we run the script, we get following output:
```
The number 5 is OK!
Traceback (most recent call last):
  File "example.py", line 9, in <module>
    verify_number(25)
  File "example.py", line 5, in verify_number
    raise ValueError(f"The number {number} is not in the allowed range!")
ValueError: The number 25 is not in the allowed range!
```

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

> [note]
>
> What does this hierarchy mean? It means that, e.g., `KeyError` is also a
> (type of) `LookupError` and `Exception` but it is not, e.g., a `SyntaxError`.
>
> You will learn more about these hierarchies and how to create them when will
> talk about the classes and inheritance. For the moment, it is enough to say
> that all exceptions are classes. `Exception` and `LookupError` are parent
> classes of `KeyError`.
>
> Once you will learn about classes you will also be able to create your own
> exceptions.

## Handling Exceptions

Why there are so many built-in exceptions?
So that we can more or less selectively catch them and handle them.

It is not always desired that the exception kill our program. And we also cannot
(or do not want to) cover all possible error conditions in the code
where the exceptions are raised from.

What we often do is that let the exceptions to be raised in the low-level
code and catch them in upper in the calling stack.

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
If there is no error, this function is executed, returns a value which
is assigned to the `number` variable and leaves the `try` block.

In case of a `ValueError` exception raised by `int()` because of an invalid input
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

A typical example would be reading input from a user. If the user
enters gibberish, it is better to ask again until the
user enters something meaningful:


```pycon
>>> def fetch_number():
...     while True:
...         answer = input("Type a number: ")
...         try:
...             return int(answer)
...         except ValueError:
...             print("Oi! This is trash, mate! Do it again!")
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
block.  The `finally` block is executed even in case of an uncaught exception
and may be used even without any `except` clause.
It is mostly used for clean-ups:

```python
try:
    # do something with an allocated resource
finally:
    # release the allocaded resource regardless of the 'try' result
```

You can also have several `except` blocks. Only one of them will be executed --
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


## Task

Let's add exception handling to our original square size calculator
(or to 1-D tick-tac-toe, if you have it)
if the user doesn't enter a number in the input.


{% filter solution %}

Possible solution for the calculator:

```python
while True:
    try:
        side = float(input("Enter the side of a square in centimeters: "))
    except ValueError:
        print("Your input is not a number!")
    else:
        if side < 0:
            print("Negative side is not allowed!")
        else:
            break

print(f"The perimeter of a square with a side of {side} cm is {side * 4} cm.")
print(f"The area of a square with a side of {side} cm is {side * side} cm2.")
```

Possible solution for 1-D tick-tac-toe:

```python
def player_move(field):
    while True:
        try:
            position = int(input(
                f"Enter a new position to fill? [1..{len(field)}]"
            )) - 1
        except ValueError:
            print("This is not a number!")
        else:
            if position < 0 or position >= len(field):
                print("You can't play outside the field!")
            elif field[position] != "-":
                print("That position isn't free!")
            else:
                break
    return field[:position] + "o" + field[position + 1:]


print(player_move("-x----"))
```

{% endfilter %}
