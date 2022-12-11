# Exceptions

We have already talked about [error messages]({{ lesson_url('beginners-en/print') }}).
When an error occurs, Python complains, tells us where the error (line) is,
and terminates the program.  But there is much more that we can learn about
error messages (aka *exceptions*).

## Printing errors:

In the beginning we will repeat how Python prints an error which is in a nested function.


```python
def outer_function():
    return inner_function(0)

def inner_function(divisor):
    return 1 / divisor

print(outer_function())
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

You notice that every function call that led to the error is listed here.
The actuall error is probably somewhere near that function call.
In our case it's easy. We shouldn't call `in_func` with argument `0`.
Or the `in_function` must be written to handle the case that the divisor can be `0`
and it should do something else than try to divide by zero.

Python can't know where the original error is that needs to be fixed, so it shows
you everything in the error message.
This will be very useful in more complex programs.


## Raising an exception

In Python, an *exception* is raised by the command `raise`.
The command is followed by the name of the exception we want to raise and
an optional short description of what went wrong (in parentheses).

```python
MAX_ALLOWED_VALUE = 20

def verify_number(number):
    if number < 0 or number >= MAX_ALLOWED_VALUE:
        raise ValueError(f"The number {number} is not in the allowed range!")
    print(f"The number {number} is OK!")

verify_number(5)
verify_number(25)
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


## Handling Exceptions

Why there are so many built-in exceptions? Because this way we can more easily
*catch* exceptions of specific error states.

It is not always desired that an exception kills our program. And we also cannot
(or do not want to) cover all possible error conditions in the code
where the exceptions are raised from.

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


## Don't catch'em all!

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

Additionally to `except`, there are two more clauses - blocks that can 
be used with `try`, and these are `else` and `finally`.

The first one `else` will be run if no exception in the `try` block was raised.
And `finally` runs every time and is executed even in the case of an uncaught exception
and may be used even without any `except` clause. It is mostly used for clean-ups.

You can also have several `except` blocks. Only one of them will be triggered. 
The first one that can handle the raised exception. 

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

Let's add exception handling and proper input checking to our square size
calculator. Modify the code so that if the user does not enter a non-negative
number the programs prompts the input again.

{% filter solution %}

```python
def input_side():
    while True:
        raw_input = input("Enter the side of a square in centimeters: ")
        try:
            side = float(raw_input)
        except ValueError:
            print(f"{raw_input} is not a number!")
        else:
            if side <= 0:
                print(f"{raw_input} is a negative number!")
            else:
                break
    return side
side = input_side()
print(f"The perimeter of a square with a side of {side} cm is {perimeter} cm.")
print(f"The area of a square with a side of {side} cm is {area} cm2.")

```

{% endfilter %}
