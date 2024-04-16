# Functions
In the one of the past [lessons]({{ lesson_url('beginners-en/functions') }}) 
we were working with functions that were written by someone else - they were
already built-in in Python - `print` or we imported them from a module - `turtle` for example.


```python
from math import pi

print(pi)
```

Today we will learn how to code our own functions
which will be helpful when we need to run tasks repeatedly.

It's not hard:


```python
def find_perimeter(width, height): 
    "Returns the rectangle's perimeter of the given sides" 
    return  2 * (width  +  height)

print (find_perimeter(4 ,  2))

```

How does it work?

You *define* a function with the command `def`. Right after that
you have to write name of the function, parentheses (which may contain 
*arguments*) and then, of course, a *colon*. 


We have already said that after a colon, everything that 
belongs to (in our case) the function must be indented. 
The indented code is called *function body* and it contains 
the commands that the function performs. 
In the body you can use various commands including `if`, `loop`, etc.

The body can start with a *documentation comment* or so called *docstring* which describes what
the function is doing.

A function can return a value with the `return` command. More on that later.


```python
def print_score(name, score): 
    print(name, 'score is', score) 
    if score > 1000:
        print('World record!') 
    elif score > 100: 
        print('Perfect!') 
    elif score > 10: 
        print('Passable.') 
    elif score > 1: 
        print('At least something. ') 
    else: 
        print('Maybe next time. ')

print_score('Your', 256) 
print_score('Denis', 5)
```

When you call a function, the arguments you write in parentheses
are assigned to the corresponding variables in the function definition's
parentheses.

So when you call our new function with `print_score('Your', 256)`,
imagine that, internally, it assigns the values like this:


```python
name = 'Your'
score = 256

print(name, 'score is', score) 
if score > 1000:
    ... #etc.
        
```
## Return

The `return` command *terminates* the function immediately and returns the calculated value 
out of the function. You can use this command only in functions!

It behaves similar to the `break` command that terminates loops.


```python
def yes_or_no(question):
    "Returns True or False, depending on the user's answers."
    while True:
        answer = input(question)
        if answer == 'yes':
            return True
        elif answer == 'no':
            return False
        else:
            print('What do you want!! Just  type "Yes" or "No".')

if yes_or_no('Do you want to play a game?'):
    print('OK, but you have to program it first.')
else:
    print('That is sad.' )

```

> [note]
> Same as `if` and `break`, `return` is a Python *command*, not a function.
> That's why `return` has no parentheses after it.

Try to write a function that returns the area of an ellipse with given 
dimensions.
The formula is <var>A</var> = π<var>a</var><var>b</var>,
where <var>a</var> and <var>b</var> are the lengths of the axes.
Then call the function and print the result.

{% filter solution %}
```python
from math import pi

def ellipse(a, b): 
    return pi * a * b
    
print('The ellipsis area with 3 cm and 5 cm axes length is', ellipse(3, 5),'cm2.')

```
{% endfilter %}


### Return or print?

The last program could be also written like that:

```python
from math import pi

def ellipse(a, b): 
    print('The area is', pi * a * b) # Caution, 'print' instead of 'return'!
    
ellipse(3, 5)

```

The program works this way, too. But it loses one of the main advantages
that functions have - when you want to use the value differently than to `print` it.

A function that *returns* its result can be used as part of other calculations:


```python
def elliptical_cylinder(a, b, height):
    return ellipse(a, b) * height

print(elliptical_cylinder(3, 5, 3))
```

But if our ellipse function just *printed* the result, we wouldn't be
able to calculate the area of elliptical cylinder this way.

The reason why `return` is better than `print` is that a function
can be re-used in many different situations. When we don't actually
want to know the intermediate results, we can't use functions with `print`. 

It is similar with input: If I hardcoded `input` into a function, I could use
it only in situations where there's a user with keyboard present.
That's why it's always better to pass arguments to a function, and call
`input` outside of the function:

```python
from  math import pi

def ellipse(a, b): 
    """This reusable function returns only the result - the ellipse's area with a and b axes"""
    #This is only the calculation
    return pi * a * b
    
#print and input are "outside" the reusable function!
x = float(input('Enter length of 1st axis: '))
y = float(input('Enter length of 2nd axis: '))
print('The ellipsis area is', ellipse(x, y),'cm2.')
```

There are of course exceptions: A function that directly generates 
a text can be written with `print`, or a function that processes text information.
But when the function calculates something it's better to not have
`print` and `input` inside it.


## None

When the function run does not end with an explicit `return`,
the value that it returns is automatically `None`.

`None` is a value that is already "inside" Python (same as `True` and `False`).
It's literally "none, nothing".

```python
def nothing():
    "This function isn't doing anything."

result = nothing()
print(result) # returns None
print(result is None) # returns True
```

## Local variables

Congratulations! You can now define your own functions!
Now we have to explain what local and global variables are.

A function can use variables from "outside":

```python
pi = 3.1415926  # a variable defined outside the function

def circle_area(radius):
    return pi * radius ** 2

print(circle_area(100))
```

But every variable and argument that is defined in the function body are
*brand new* and they share nothing with the "outside" variables.

Variables that are defined inside a function body are called *local variables*,
because they work only locally inside the function.

For example, the following won't work how you would expect:

```python
x = 0  # Assign value to global variable x

def set_x(value):
    x = value  # Assign value to local variable x

set_x(40)
print(x)
```

Variables that are not local are *global variables* -
they exist throughout the whole program.

If a function defines a local variable with the same name, this local variable will only  
have the value that was assigned in the function.

Let's look at an example.
Before you run the next program, try to guess how it will behave.
Then run it, and if it did something different than
you expected, try to explain why.
There is a catch! :)

```python
from math import pi
area = 0
a = 30

def ellipse_area(a, b):
    area = pi * a * b  # Assign value to 'area`
    a = a + 3  # Assign value to 'a`
    return area

print(ellipse_area(a, 20))
print(area)
print(a)
```

Now try to answer the following questions:

* Is the variable `pi` local or global?
* Is the variable `area` local or global?
* Is the variable `a` local or global?
* Is the variable `b` local or global?


{% filter solution %}
* `pi` is global - it's not defined within the function and it's
accessible in the whole program.
* `area` - Note there are two variables of that name! One is global
ant the other one is local inside the function `ellipse_area`.
* `a` - Note there are also two variables of that name. This was that catch:
Writing `a = a + 3` has no point. A value is assigned to the local
variable `a`, but the function ends right after that, and this `a` is no 
longer available, it will never be used.
* `b` is only local - it's an argument for the `ellipse_area` function. 

{% endfilter %}

If it seems confusing and complicated just avoid naming variables (and
function's arguments) within a function the same as those outside.

## Arguments, their count and defaults

If you define a function with a certain number of `positional arguments`, then the calling of the
function needs to pass all of these arguments as well. Following will happen if too little 
arguments are passed in.

```python
def say_name_5(first_name, last_name):
    for i in range(5):
        print(first_name.upper() + " " + last_name.upper())

say_name_5("Eva", "Blasco")

say_name_5("Eva")
# TypeError: say_name_5() missing 1 required positional argument: 'last_name'
```

But in this case, we should not be forced to input both First name and Surname.
There are powerful and well known people without a Surname, that would not be able to use our 
function without a workaround - like setting their surname to empty string `""`.

### Defaults

It is possible (although it does not always make sense) to add `default` argument values
which will get used if the function call does not have these arguments specified.

For specifying default argument, we use `argument=value` syntax in the function definition:

```python
def say_name_5(first_name="", last_name=""):
    if (first_name != "" or last_name != ""):
        for i in range(5):
            print(first_name.upper() + " " + last_name.upper())
    else:
        print("Warning: Use this function with at least a first name")

say_name_5("Eva")
say_name_5()

```

A problem also appears in case we supply more arguments than the function allows:

```python
say_name_5("Eva", "Blasco", "of Royal Court!")

# TypeError: say_name_5() takes 2 positional arguments but 3 were given
```

Remember that for positional arguments, the order in which they are passed in is important.

## Recursion

*Recursion* is a programming technique,
when a function calls itself.

Such a recursion will end in an infinite call.
When you enter this program:

```python
def recursive_function():
     result = 1+2
     recursive_function()
     return result

recursive_function()
```

How does it work?

* Python defines a function `recursive_function`
* Calls the function `recursive_function`:
   * Calculates the result
   * Calls the function `recursive_function`:
     * Calculates the result
     * Calls the function `recursive_function`:
       * Calculates the result
       * Calls the function `recursive_function`:
         * Calculates the result
         * Calls the function `recursive_function`:
           * ...
             * ...
                * after hundreds of iterations, Python notices that this
                  leads nowhere, and ends up with an error.

The error message corresponds to this:

```
Traceback (most recent call last):
   File "/tmp/test.py", line 4, in <module>
     recursive_function()
   File "/tmp/test.py", line 2, in recursive_function
     return recursive_function()
   File "/tmp/test.py", line 2, in recursive_function
     return recursive_function()
   File "/tmp/test.py", line 2, in recursive_function
     return recursive_function()
   [Previous line repeated 996 more times]
RecursionError: maximum recursion depth exceeded
```

## Controlled nesting

How to use recursion in practice?
One way is to count how many more times to "dive".

Imagine a diver exploring the depths of the sea in the following way:

* How to *"explore the sea"* at a certain depth:
   * I look around
   * If I'm already in too deep, I am scared. I will not explore further.
   * Otherwise:
     * I dive 10 m lower
     * *I will explore the sea* at a new depth
     * I submerge again in 10 m

Or in Python:

```python
def explore(depth):
     print(f'Looking around at a depth of {depth} m')
     if depth >= 30:
         print('Enough! I have seen it all!')
     else:
         print(f'I dive more (from {depth} m)')
         explore(depth + 10)
         print(f'Surfacing (at {depth} m)')

explore(0)
```

```
* Python defines the function ``explore''
* Calls the `explore` function with a depth of 0:
   * Prints `I'm looking around at a depth of 0 m'
   * Checks that `0 ≥ 30` (which is not true)
   * Prints ``I dive more (from 0 m)''
   * Calls the `explore` function with a depth of 10 m:
     * Writes `I look around at a depth of 10 m'
     * Checks that `10 ≥ 30` (which is not true)
     * Writes ``'I dive more (from 10 m)''
     * Calls the `explore` function with a depth of 20m:
       * Checks that `20 ≥ 30` (which is not true)
       * Writes ``I dive more (from 30 m)''
         * Calls the `explore` function with a depth of 30 m:
           * Checks that `30 ≥ 30` (which is true! finally!)
             * Prints ``Enough! I have seen it all!''
             * and ends
       * Prints ``Surfacing (at 20 m)''
     * Prints ``Surfacing (at 10m)''
   * Prints ``Surfacing (at 0 m)''
```

## Factorial

Recursive algorithms have their origins in mathematics. The factorial of <var>x</var>, or
the product of all numbers from 1 to <var>x</var>, written as <var>x</var>!,
mathematicians define as follows:

* 0! = 1
* For positive <var>x</var> is <var>x</var>! = <var>x</var> · (<var>x</var> - 1)!

Or in Python:

```python
def factorial(x):
     if x == 0:
         return 1
     elif x > 0:
         return x * factorial(x - 1)

print(factorial(5))
print(1 * 2 * 3 * 4 * 5)
```
