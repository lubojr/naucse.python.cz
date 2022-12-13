You've already learned that it is not convenient write longer programs in the
Python interpreter and you've been writing your Python *scripts* as
text files with the `.py` extension.

The scripts can be easily edited and executed repeatedly. This works nicely
up to the point when it becomes too limiting to hold all our code in a
single file (e.g., the script becomes too long, parts of code repeat in
different scripts).

Can we organize our code better than that? The answer is *yes*, with the Python
*modules*.

# Modules

Python allows us to organize code in *modules*. A *module* is something like
a box containing some ready-to-use code.  We can pull it from a shelf, *import*
it, and then use it in our script.

For example, you can import the function `sqrt` from
the module `math`:

```python
from math import sqrt

print(sqrt(2))
```

In this case, the module `math` (Python standard library)
contains a set of various mathematical functions and constants.
With the `from <module> import <names>` command we pulled from the
`math` modules one function `sqrt`, which refers
to the function calculating [square root](https://en.wikipedia.org/wiki/Square_root),
and made it available in our program.

Alternatively, you can import a whole module and access its names through
the module name and period `.`. For example:

```python
import math

print(math.cos(math.pi))
```

... or:

```python
import turtle

turtle.left(90)
turtle.color('red')
turtle.forward(100)
turtle.exitonclick()
```

## Packages

Python allows a special kind of module which itself contains sub-modules.
A module which is a collection of modules is called a *package* in the Python
jargon. A package can have sub-packages and, in more complex projects, it is
common to have several levels of sub-modules.

Do not fear! Import of a sub-module from a *package* does not differ from the
regular top-level module. The sub-modules are separated by dots, but apart from
that, you work with them the same way:

```python
import os       # os is a module
import os.path  # path is submodule of os package, os.path is a full module name

directory = "./test"
if not os.path.exists(directory):
    os.mkdir(directory)
```

## Custom modules

Creating a new Python module is easy, just create a new Python file.
The function and global variables that you create in this file will become
available for import.

You can also create your own module, simply, by creating a Python file.
Functions and variables (and other named objects) that you create there will be available
in programs where you import this module.

Let's try it. First, create a new Python file `meadow.py` and write:


```python
meadow_colour = 'green'
number_of_kitties = 28

def description():
    return 'The meadow is {colour}. There are {number} kitties.'.format(
        colour=meadow_colour, number=number_of_kitties)
```

And then write in another file `write.py` with the following content:

```python
import meadow

print(meadow.description())
```

and run:

```console
$ python3 write.py
```

Python searches for the imported modules in the same folder where
the executed script is located. Please make sure both files are placed
in the same folder.

## Import mechanics and undesired side-effects

What exactly does the command `import meadow` do?

First, Python looks for a matching file (`meadow.py`) and runs all the commands
in the file, from top to bottom, like it was a regular script.
Once it is done, all the names in the global scope (variables, functions,
etc.) are remembered and made available for use outside of the module.

When you try to import the same module again, the commands in the module
are not executed and Python re-uses the already initialized module.

Try it! Write in the end of `meadow.py`:

```python
print('The meadow is green!')
```

And then run `python` in the command line (if you already have an interactive
Python open, close it, and run again) and enter:

```pycon
>>> import medow
The meadow is green!
>>> import medow
>>> import medow
>>>
```

The message we print at the end of the module appears only once.

When the module is "doing something" (it prints something, asks the user,
writes something into a file) we say that it has a *side effect*.
We generally try to avoid writing modules with side effects.
The purpose of a module is to give us *functions*, that we
will use to do something, not to do it instead of us.
E.g., when we write `import turtle`, no window opens. It opens
only when we write `turtle.forward()`.

So you had better delete the `print` from our module.

## One directory for every project

From now on, we will work on bigger projects that contain
more files. We recommend that you create a folder for each
of them.


## The `import` best practice

### Where to put the imports?

Always keep imports at the top of your script before you the start of your
own code.

### Does the order of the imports matter?

Generally, the order of the imports does not matter, though, we often
order the imports, starting with the modules from the Python system
library (e.g., `math`), then third-party libraries
(e.g., `turtle` installed with the `pip` command),
and last come imports from our own modules.


Do not repeat imports from the same module like, e.g.:

```python
from math import pi
from math import sin, cos
```

If you decide to import multiple names from the module do it in one import
command, e.g.:

```python
from math import pi, sin, cos
```

## Further reading
You can find more info about [import and modules here](https://chrisyeh96.github.io/2017/08/08/definitive-guide-python-imports.html#basics-of-the-python-import-and-syspath).
