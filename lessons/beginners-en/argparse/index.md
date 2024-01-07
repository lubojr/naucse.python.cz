Command line interface in Python
=======================================

In this lesson, we will show you how to create your own command line interface tool `(CLI)` using Python using the `argparse` library. Primarily this means program argument processing.

## Command line interface

... is one of ways how to interact with or control a program (not only Python scripts!) as a user - **interface** with it from inside the computer itself where it is installed (not over the internet).
That user can be you as a creator of code and someone else you give access to it.

### Motivation

In the [testing lesson]({{ lesson_url('beginners-en/testing') }}) we have shown that sometimes you need to call a Python program independently with different arguments in order to run computations with different values.

Letting the tester or user pass these **arguments** from command line (which means not manually editing them inside the Python script) is a great option.

The behavior of a program usually is varying - it depends on the instructions 
you give to it as **arguments**.

### Example

An example of a tool which is usually installed on both Windows and Unix is ``curl``. It allows you to send HTTP requests to the internet and receive responses.

If you want to know what arguments does existing program allow, the argument to use is **help**. This works for most of programs on your computer (if their author created a help page). Also usually there is a `-help` or `--help` command line argument which also shows the expected usage of a tool to any user.

#### git

As an example of a tool which works on both Linux and Windows mostly the same way, you can take our beloved [git]({{ lesson_url('git-en/basics') }}).

Try running this in your terminal:

```console
git --help
```

and for any subcommand as well:

```console
git log --help
```

Now that you know that programs usually accept arguments and they are documented in ``help``, you can start using ``git`` in many ways.
For example you can heavily customize output of `git log` in some existing git repository:

```console
git log --oneline --graph --decorate --cherry-mark --boundary
```

Another example of a command line tool with arguments is **find** but does different things on Windows and Linux. This example is valid for Linux:

```console
find . -type f -name "*.txt" -empty
```

Which searches current directory for empty files with .txt suffix.

### Argparse

How can we create a CLI in Python? Today, we will show usage of a `argparse` tool.

It is a part of the standard library, so you do not need to install anything extra.

You can find the official documentation on:

- [argparse](https://docs.python.org/3/library/argparse.html)

And a quite handy tutorial going through most of functionalities, you could ever encounter:
[argparse-tutorial](https://docs.python.org/3/howto/argparse.html)

Additionally there is quite commonly used `click` library, which you would need to install via pip
and uses a decorator syntax, that we have not seen yet, so it can remain as self study.

#### argparse basic usage

Usually when we send our Python code to someone else, we do not expect them to read the whole code but reading the help should be enough for them to use it and change parameters.

For Python CLI tools, you would get the help this way, which you see is the same as for `git`:

```console
python3 hello.py --help
```

Here's how to create Python command line application with switches:

But first lets start with a function that greets the user for a given number of times and optionally can indent the greeting.

Lets save the following code into `hello.py` file.

```python
def hello(count, name, indent=False):
    """Simple program that greets 'name' for a total of 'count' times and optionally indents."""
    for _ in range(count):
        if indent:
            print("    ", end="")
        print(f"Hello {name}!")

count = 5
name = "Tyna"
indent = True
hello(count, name, indent)
```

And run it as usual as `python hello.py`.

Now we want the arguments `count`, `name` and `indent` to be enabled as CLI options and come from command line arguments when you start the script.

```python
import argparse

parser = argparse.ArgumentParser(description='argparse greeting')
parser.add_argument('-n', '--name', help='a name to repeat', required=True)
parser.add_argument('-c', '--count', help='how many times', required=True, type=int)
parser.add_argument("--indent", action="store_true", help=("name will be indented by 4 spaces"))

def hello(count, name, indent=False):
    """Simple program that greets 'name' for a total of 'count' times and optionally indents."""
    for _ in range(count):
        if indent:
            print("    ", end="")
        print(f"Hello {name}!")

args = parser.parse_args()
hello(args.count, args.name, args.indent)
```

The first step in using the argparse is creating an `ArgumentParser` object with some description.
Then you fill an `ArgumentParser` with information about program
arguments, which is done by making calls to the `add_argument()` method.
This information is stored and used when `parse_args()` is called.

You can set parameters as required by adding `required=True` option.
It is also possible to their `type`, which will try to convert the variable to the data type announced.
In order to allow simple storing of boolean flags `True/False`, you can use the `action="store_true"` parameter.

```console
python3 hello.py
python3 hello.py --help
python3 hello.py --name PyLady
python3 hello.py --count 5
python3 hello.py --count 5 --name PyLady
python3 hello.py --count 5 --name PyLady --indent
```

That is already a very solid first program is it not?

## Positional arguments

You can of course define arguments, which are `positional` in the same way as when you are defining and using function arguments. The parsing will expect all arguments to be in the order, in which you defined them.

To try it, replace the first two lines with `name` and `count` arguments with following lines:

```python
parser.add_argument("name", help='a name to repeat')
parser.add_argument("count", help='how many times', type=int)
```

From now on, the order in which you provide `name` and `count` arguments will be important. The named arguments can still be provided before or after the positional arguments.

```console
python3 hello.py PyLady 5 --indent
```

An example of a wrong call would be:

```console
python3 hello.py 5 PyLady
```

Which should run into following error:

```
hello.py: error: argument count: invalid int value: 'PyLady'
```

## Other options

Switch names begin, according to Unix convention, with hyphens: one hyphen `-`
for one-letter abbreviations, two hyphens `--` for multi-letter names.
One switch can have more than one name - short option and long option.

This example shows how it is usually done for example of `logging` setup - although it does not apply for our simple example.

```python
parser.add_argument(
        "-v", "--verbosity", type=int, default=3, choices=[0, 1, 2, 3, 4],
        help=(
            "Set verbosity of log output "
            "(4=DEBUG, 3=INFO, 2=WARNING, 1=ERROR, 0=CRITICAL). (default: 3)"
        ),
    )
```

Parameter names with `hyphens` inside them will automatically turn them into variable names 
with `underscores`, as it is not possible to have a `hyphen -` in variable name in Python.

```python
parser.add_argument(
        "--extreme-universe",
        action="store_true", help=("Computations will return all results to the power of 2.")
    )
args = parser.parse_args()
print(args.extreme_universe)

```

If you use more options with two hyphens, you need to access the values from the `args`
object via the first option, as in this example:

```python
parser.add_argument('-n', '--name', '--firstname', help='a name to repeat', required=True)
hello(args.count, args.name, args.indent)
```

```console
# both work
python3 hello.py --name PyLady --count 5
python3 hello.py --firstname PyLady --count 5
```

This has been a short introduction into working with CLI.
