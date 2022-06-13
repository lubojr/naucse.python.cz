# Tuples

Now that we know about lists, let's look at their *immutable* sibling, *tuples*.

The name tuple originates from the suffix of the sequence of <var>n</var>
elements (single, couple/double/pair, triple, quadruple, quintuple,
sextuple, septuple, ... <var>n</var>‑**tuple**)

Tuples (literals) are written just like lists, but without the square brackets:

```pycon
>>> 1, 2, 3
(1, 2, 3)
>>> 1, # single element tuple with a trailing comma - not recommended
(1,)
```

The tuple literals are often written with round brackets. It is
also the way Python prints them:

```pycon
>>> (1, 2, 3)
(1, 2, 3)
>>> (1,) # single element with a trailing comma with brackets - recommended
(1,)
>>> () # empty tuple - cannot be written as a literal without brackets
()
```

Alternatively, you can also create tuples with the `tuples` constructor:

```pycon
>>> tuple()  # empty tuple
()
>>> tuple(range(3)) # accepts anything which can be used in for loops
(0, 1, 2)
```

## Tuples with round brackets or no brackets?

With exception of the empty tuple, tuples are made by the commas rather
than by the round brackets.
However, we very often need to surround them with round brackets
to achieve our goal. The tuples therefore may sometimes look like
"lists written with round brackets" even though there are not.

Fell free to use tuples without the brackets but, be aware
that there are cases where they can lead to ambiguities and errors:

```pycon
>>> 1, 2, 3 + 4, 5, 6
(1, 2, 7, 5, 6)
>>> (1, 2, 3) + (4, 5, 6)
>>> (1, 2, 3, 4, 5, 6)
```

... or:

```pycon
>>> 1, 2, 3 == 4, 5, 6
(1, 2, False, 5, 6)
>>> (1, 2, 3) == (4, 5, 6)
False
```

Always use round brackets when passing tuples as function arguments
to distinguish them from function arguments:

``` pycon
>>> sorted(2, 4, 5, 1, 0)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: sorted expected 1 argument, got 5
>>> sorted((2, 4, 5, 1, 0))
[0, 1, 2, 4, 5]
```

It is highly recommended to write single element tuples with brackets '(1,)'.
The trailing comma looks like a typo `1,` and the extra round brackets improve
clarity of the code.


## How to use tuples

Tuples behave almost like lists, but they cannot be modified.
I.e., they don't have methods like `append` and `pop`,
elements cannot be assigned or removed:

```pycon
>>> my_tuple = (1, 2, 3)

>>> my_tuple.append(1)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: 'tuple' object has no attribute 'append'

>>> my_tuple.pop(1)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: 'tuple' object has no attribute 'pop'

>>> my_tuple[1] = -2
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object does not support item assignment

>>> del my_tuple[1]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object doesn't support item deletion
```

A "modification" of a tuple always requires creation of a new tuple object.

Tuple manipulations using Python asterisk unpacking:

```pycon
>>> sample = (1, 2, 3)

>>> *sample, 4
(1, 2, 3, 4)

>>> *sample, *sample[-2:]
(1, 2, 3, 2, 3)

>>> *sample[:1], -2, *sample[2:]
(1, -2, 3)

>>> *sample[:1], *sample[2:]
(1, 3)
```
> [note]
> `*` in the expressions unpacks the given sequences (list, tuple, range, ... etc.).
> Mixing list and tuples in these expressions is possible.
>
> FYI, this also works with lists. Try `[*sample[:1], -2, *sample[2:]]`.

... or `+` concatenation of tuples:

```pycon
>>> sample = (1, 2, 3)

>>> sample + (4,)
(1, 2, 3, 4)

>>> sample + sample[-2:]
(1, 2, 3, 2, 3)

>>> sample[:1] + (-2,) + sample[2:]
(1, -2, 3)

>>> sample[:1] + sample[2:]
(1, 3)
```

> [note]
> Tuple concatenation with the `+` operator works only with tuples.
> Mixing list and tuples in these expressions leads to an error.

Tuples can be to converted from/to lists:

```pycon
>>> tuple([1, 2, 3]) # list to tuple
(1, 2, 3)

>>> list((1, 2, 3)) # tuple to list
[1, 2, 3]
```

Tuples can be nested. Mixing nested list and tuples is possible:
```pycon
>>> 42, ("Hotel", "Golf", "Tango", "Golf")
(42, ('Hotel', 'Golf', 'Tango', 'Golf'))

>>> "John", "Doe", [3, 4 , 2], True
('John', 'Doe', [3, 4, 2], True)

>>> [(1, 1), (0, 4), (4, 5)]
[(1, 1), (0, 4), (4, 5)]
```

> [note]
>
> Beware that nested mutable value (list) makes a tuple object mutable with all
> the possibly undesired consequences.

Tuples can be used in `for` loops
and they can read individual elements.

```python
people = 'mom', 'aunt', 'grandmother'
for person in people:
    print(person)
print('First is {}'.format(people[0]))
```

> [note]
> Does this look familiar?
> We have already used tuples in
> `for greeting in 'Ahoj', 'Hello', 'Hola', 'Hei', 'SYN'`


Short tuples can also be used to simplify conditions:

```python
if code in (1, 4, 7):
    # do something ...
```

is equivalent to

```python
if code == 1 or code == 4 or code == 7:
    # do something ...
```

## Tuples and functions

Tuples are used in functions with variable number of arguments:

```pycon
>>> def print_sum(*values):    # values variable holds a tuple of free arguments
...     print(f"sum({values}) = {sum(values)}")
...
>>> print_sum(1, 2)
sum((1, 2)) = 3
>>> print_sum(1, 2, 4, 5)
sum((1, 2, 4, 5)) = 12
```

Tuples are used if we need to return more than one value from a function.
You simply declare the return values separated with comma.
It looks like you're returning multiple values, but in fact,
it is just one tuple being returned:

```python
def floor_and_remainder(a, b):
    return a//b, a%b
```

> [note]
> Such a `floor_and_remainder` function already exists
> in Python: it's called `divmod` and it's always
> available (you don't have to import it).


## Multiple assignment

Python can do another trick: if you want to assign values
into several variables at once, you can just separate the variables
(the left side) by a comma, and the right side can be some
"compound" value - for example a tuple:

```python
floor_number, remainder = floor_and_remainder(12, 5)
```

A tuple is the best for this purpose, but
it works with all the values ​​that can be used with a `for` loop:

```python
x, o = 'xo'                       # is like: x = 'a'; o = 'o'
one, two, three = [1, 2, 3]       # is like: one = 1;  two = 2; three = 3
a, b = 1, 2                       # is like: a = 1;  b = 2
first, *body, last = range(4)     # is like: first = 0 ; body = [1, 2], last = 3
```

> [note]
> `*` in the last assignment grabs anything between the first
> and last elements and stores it as an array.

## Functions producing tuples

`zip` is an interesting function.
It is used in `for` loops, just like the `range` function that returns numbers.

E.g., when `zip` gets two lists (or other values that can be used in a `for` loop),
it returns pairs -- the first element of the first list is paired with
the first element of the second list,
then the second element with the second, the third element with the third and so on.

It is useful when you have two lists with the same
structure - the relevant elements "belong" together
and you want to process them together:

```pycon
>>> list(zip([3, 1, 2], ["a", "b", "c"])
[(3, 'a'), (1, 'b'), (2, 'c')]
```

```python
people = 'mom', 'aunt', 'grandmother', 'assassin'
properties = 'good', 'nice', 'kind', 'insidious'
for person, property in zip(people, properties):
    print ('{} is {}'.format(person, property))
```

> [note]
> Note the tuple multiple assignment in the for statement.

When `zip` gets three lists it will return triplets, and so on.

The other function that returns pairs is `enumerate`.
As an argument, it takes a list (or other values that can be used in a `for` loop)
and it pairs up the element's index (its order in the list) with the respective element.
So the first element will be (0, *first element of the given list*), then
(1, *second element*), (2, *third element*) and so on.


```pycon
>>> list(enumerate(["a", "b", "c"])) # count from 0
[(0, 'a'), (1, 'b'), (2, 'c')]

>>> list(enumerate(["a", "b", "c"], 1)) # count from 1
[(1, 'a'), (2, 'b'), (3, 'c')]
```

```python
prime_numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

for i, prime_number in enumerate(prime_numbers):
    print('Prime number on position {} is {}'.format(i, prime_number))
```

## When to use the list and when the tuple?

Lists are used when you do not know in advance
how many values you will have,
or when there are a lot of values.
Simply use *lists* for list of things,
e.g., a list of words in a sentence,
a list of contest participants, a list of moves in a game,
or a list of cards in a deck.

Tuples are often used for values
of different types where each "position"
inside the tuple has a different meaning.
For example, you can use a list for the letters of the alphabet,
but for pairs of index-value from `enumerate`, you'd use a tuple.

The empty and one-element tuples are little strange, but they exist,
and Python would not be complete without them.

Both lists and tuples also have limitations or benefits (depending on your point
of view). Tuples cannot be changed, and when we will learn how to work with
dictionaries, we will find that lists cannot be used as dictionary keys.

Often, it is not entirely obvious which type to use
-- in that case, it probably doesn't really matter.
Follow your instinct. :)


## Exercise
Let's get back to our `table_parser`.

```python
SOURCE_TRANSLITERATION_TABLE_UA_GB = """
а a
б b
в v
г h
ґ g
д d
е e
є ye
ж zh
з z
и ȳ
і i
ї yi
й ĭ
к k
л l
м m
н n
о o
п p
р r
с s
т t
у u
ф f
х kh
ц ts
ч ch
ш sh
щ shch
ь ʼ
ю yu
я ya
’ ˮ
"""


def parse_table(source):
    """ Parse string table. """
    table = []
    for line in source.splitlines():
        row = line.split()
        if row: # ignore empty lines
            table.append(row)
    return table


table = parse_table(SOURCE_TRANSLITERATION_TABLE_UA_GB)

print(table)
```

#### Task 2
1. Modify the `parse_table` function so that it produces table as a list of
tuples rather than a list of list.
2. Generate the table again.

{% filter solution %}
```python
...

def parse_table(source):
    """ Parse string table. """
    table = []
    for line in source.splitlines():
        row = line.split()
        if row: # ignore empty lines
            table.append(tuple(row))
    return table

table = parse_table(SOURCE_TRANSLITERATION_TABLE_UA_GB)

print(table)
```
{% endfilter %}


#### Task 3
1. Write a new `add_capitals` function which extend the table by adding capital
   letters. Use to `string.upper` for the source Cyrillic letters and
   `str.capitalize` for the Latin transcription.
2. Extend the parsed table with the capital letters.

{% filter solution %}
```python
...

def add_capitals(table):
    """ Add capital letters to the transliteration table. """
    new_table = []
    for source, transcription in table:
        new_table.append(
            (source.upper(), transcription.capitalize())
        )
    return table + new_table


table = parse_table(SOURCE_TRANSLITERATION_TABLE_UA_GB)
table = add_capitals(table)

print(table)
```
{% endfilter %}
