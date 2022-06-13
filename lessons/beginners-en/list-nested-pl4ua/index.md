This is completion of the list lesson started last week.

## Nested lists

In the beginning of this lesson we said that a list
can contain any type of value.  A list can even contain other lists:

```pycon
>>> list_of_lists = [[1, 2, 3], [4, 5], [6], []]
>>> list_of_lists
[[1, 2, 3], [4, 5], [6], []]
```

Such a list behaves as expected - we can choose
elements (which are, of course, lists):

```pycon
>>> list_of_lists[0] # the first list
[1, 2, 3]
>>> list_of_lists[1] # the second list
[4, 5]
>>> list_of_lists[2] # the third list
[6]
```

And since elements are themselves lists,
we can talk about elements like "the first element of the second list":

```pycon
>>> second_list = list_of_lists[1]
>>> second_list
[4, 5]
>>> second_list[0] # the first element of the second list
4
```

And because `second_list` is `list_of_lists[1]` we can take the elements
directly from it and omit the superfluous variable:

```pycon
>>> (list_of_lists[1])[0]
4
```

Or simply:

```pycon
>>> list_of_lists[1][0]
4
```

Lists can be modified and so do the nested lists. You can assign to the nested
lists, append, extent, pop, ... etc.
```pycon
>>> list_of_lists
[[1, 2, 3], [4, 5], [6], []]
>>> list_of_lists[1][0] = "Hi, Bob!"
>>> list_of_lists
[[1, 2, 3], ['Hi, Bob!', 5], [6], []]
>>> list_of_lists[2].append(0)"
>>> list_of_lists
[[1, 2, 3], ['Hi, Bob!', 5], [6, 0], []]
```

You can also assign a list as its own element
```pycon
>>> list_of_lists
[[1, 2, 3], ['Hi, Bob!', 5], [6, 0], []]
>>> list_of_lists[3] = list_of_lists
>>> list_of_lists
[[1, 2, 3], ['Hi, Bob!', 5], [6, 0], [...]]
>>> list_of_lists[3]
[[1, 2, 3], ['Hi, Bob!', 5], [6, 0], [...]]
>>> list_of_lists[3][3]
[[1, 2, 3], ['Hi, Bob!', 5], [6, 0], [...]]

```
> [note]
> This situation called a *circular reference*. Python handles circular
> references gracefully, though you should use them wisely.
> Circular references have sharp teeth and can bite!


List nesting is quite useful and allows us to to store tabular data,
like in the following example:

```python

def create_table(size=11):
    """ Generate mutiplication table. """
    table = []
    for a in range(size):
        row = []
        for b in range(size):
            row.append(a * b)
        table.append(row)
    return table


def multiply(table, a, b):
    """ Multiply two integers by means a multiplication table. """
    print(f"{a} x {b} = {table[a][b]}")


def print_table(table):
    print("Multiplication table:")
    for row in table:
        for value in row:
            print("{:3d}".format(value), end=" ")
        print()


multiplication_table = create_table()
print("multiplication_table =", multiplication_table)
print_table(multiplication_table)
multiply(multiplication_table, 2, 3)
multiply(multiplication_table, 4, 6)
```

```
multiplication_table = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20], [0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30], [0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40], [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50], [0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60], [0, 7, 14, 21, 28, 35, 42, 49, 56, 63, 70], [0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80], [0, 9, 18, 27, 36, 45, 54, 63, 72, 81, 90], [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]]
Multiplication table:
  0   0   0   0   0   0   0   0   0   0   0
  0   1   2   3   4   5   6   7   8   9  10
  0   2   4   6   8  10  12  14  16  18  20
  0   3   6   9  12  15  18  21  24  27  30
  0   4   8  12  16  20  24  28  32  36  40
  0   5  10  15  20  25  30  35  40  45  50
  0   6  12  18  24  30  36  42  48  54  60
  0   7  14  21  28  35  42  49  56  63  70
  0   8  16  24  32  40  48  56  64  72  80
  0   9  18  27  36  45  54  63  72  81  90
  0  10  20  30  40  50  60  70  80  90 100
2 x 3 = 6
4 x 6 = 24
```

## Exercise

Now, let's try yourself to create a nested list in a real world example.
This is a simple table mapping Ukrainian Cyrillic to its phonetic equivalent
written in Latin script, stored as a multi-line string

```
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
```

> [note]
> This is the British standard Ukrainian romanization.
> Additional rules were omitted for the sake of simplicity.
> Source [wikipedia](https://en.wikipedia.org/wiki/Romanization_of_Ukrainian).


#### Task 1
1. Write a function named `parse_table` which turns the string with the table
   into a list of nested list.
2. To achieve this, first, split the source string into lines
   with the `str.splitlines` mehtod.
3. Split each line (space separated values) into a list with the `str.split`
   method.
4. Skip  the empty lines, i.e., do not store empty rows list.
2. Call the `parse_table` function with the `SOURCE_TRANSLITERATION_TABLE_UA_GB`
   string as its argument. Store the result into a new variable.

{% filter solution %}
```python
...

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
{% endfilter %}

That is all for now.  Please, keep the table parsing function, we will need
it later.
