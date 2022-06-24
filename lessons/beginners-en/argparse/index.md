argparse
========

The `argparse` library is used to create a command line interface - CLI.
Primarily this means program argument processing. It is a part of the standard library, so you do not need to
install anything extra.

## Command line interface

... is one of ways how to interact with or control a program (or Python script) as a user - **interface** with it
from inside the computer itself where it is installed (not over the internet).
That user can be you as a creator of code and someone else you give access to it.


The behavior of a program usually is varying - it depends on the instructions 
you give to it.

Adding command line arguments to a program enables terminal magic using `find` command like this:

```console
find . -type f -name "*.txt" -empty -mtime 30
```

Which searches current directory for empty files with .txt suffix and a modification date older than 30 days.
The find command internally has a lot of switches controlling its
behavior while filtering the folder(s) is is searching through
based on user given parameters of the search.

### Examples of libraries & argparse

Quite many tools for processing arguments from the CLI are also present in the standard Python:
`sys.argv`, `optparse`, `getopt`.
Additionally there is quite commonly used `click` library, which you would need to install via pip
and uses a decorator syntax, that we have not seen yet, so we have decided not to delve into it.

You can find the official documentation on:

- [argparse](https://docs.python.org/3/library/argparse.html)
- [sys.argv](https://docs.python.org/3/library/sys.html#sys.argv)
- [optparse](https://docs.python.org/3/library/optparse.html)
- [getopt](https://docs.python.org/3/library/getopt.html)

And a quite handy tutorial going through most of functionalities, you could ever encounter:
[argparse-tutorial](https://docs.python.org/3/howto/argparse.html)

Here's how to easily create Python command line application with switches:

```python
import argparse

parser = argparse.ArgumentParser(description='argparse greeting')
parser.add_argument('-n', '--name', help='a name to repeat', required=True)
parser.add_argument('-c', '--count', help='how many times', required=True, type=int)
parser.add_argument("--indent", action="store_true", help=("name will be indented by 4 spaces"))

args = parser.parse_args()

def hello(count, name, indent=False):
    """Simple program that greets 'name' for a total of 'count' times and optionally indents."""
    for _ in range(count):
        if indent:
            print("    ", end="")
        print(f"Hello {name}!")

hello(args.count, args.name, args.indent)
```

The first step in using the argparse is creating an `ArgumentParser` object with some description.
Then you fill an ArgumentParser with information about program
arguments, which is done by making calls to the `add_argument()` method.
This information is stored and used when `parse_args()` is called.

You can set parameters as required by adding `required=True` option.
It is also possible to their `type`, which will try to convert the variable to the data type announced.
In order to allow simple storing of boolean flags `true/false`, you can use the `action="store_true"` parameter.

Try it! If you have it saved as `hello.py`, try:

```console
python hello.py
python hello.py --help
python hello.py --name PyLady
python hello.py --count 5
python hello.py --count 5 --name PyLady
python hello.py --count 5 --name PyLady --indent
```

That is already a very solid first program is it not?

## Positional arguments

You can of course define arguments, which are `positional` in the same way as when you are defining and calling
a function. The parsing will expect all arguments to be in the order, you defined them.

```python
parser.add_argument("input_file", default=None, help=("Input file to read"))
```

```console
python hello.py input.txt --count 5 --name PyLady

```

## Other options

Switch names begin, according to Unix convention, with hyphens: one hyphen `-`
for one-letter abbreviations, two hyphens `--` for multi-letter names.
One switch can have more than one name - short option and long option.

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
with `underscores`, as it is not possible to have a `hyphen` in variable name in Python.

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
python hello.py --name PyLady --count 5
python hello.py --firstname PyLady --count 5
```

This has been a short introduction into working with CLI.

A small exercise is prepared for you to straighten up your understanding of CLI and practice a bit.

## Task

- Write a new text file in your editor, naming as it you like, save it.

- Create a simple CLI Python program, which will receives **input_file** argument and an **output_file** arguments.

- The Python code should **read** the **input_file**, perform some kind of operation on the text content of the file and **write** the content to the **output_file**.

- Some example of the operation to perform would be: changing the text to Capital letters or replacing certain letters with numbers.

- Add some **optional** command line parameters of your choice and add one boolean **flag** parameter.

Please **note**! that opening a file in a `w` mode replaces all contents of that file!!
Try to use the CLI you have built.
