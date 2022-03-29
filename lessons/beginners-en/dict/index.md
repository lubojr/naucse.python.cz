# Dictionaries

Another basic data type which we will introduce is the
*dictionary*, or short, `dict`.

Similar to lists, dictionaries contain values.
In contrast to lists, where all elements are in a specific order, there are two types
of elements in dictionaries: *key* and *value*. 
Exactly one value exists for every key. (I don't want to confuse you right at the beginning,
but just so you know -- an empty list can also be a value for a key.)

You use a dictionary when each piece of data has an individual name, but you want 
to work with the data as one variable.

There is a dictionary with 3 keys, and each one of them has a value:

```pycon
>>> me = {'name': 'Marketa', 'city': 'Prague', 'numbers': [20, 8]}
```

When you print the dictionary you may find that 
your keys and values are in a different order.
Dictionaries don't have a fixed order of elements. They just 
assign values to keys.


You can get values from the dictionary similar as
from lists, but instead of an index, you have to use the key. 

```pycon
>>> me['name']
'Marketa'
```

If you try to access a non-existent key, Python won't like it:

```pycon
>>> me['age']
Traceback (most recent call last):
  File "<stdin>", line 1, in &lt;module&gt;
KeyError: 'age'
```

You can change the values of keys:

```pycon
>>> me['numbers'] = [20, 8, 42]
>>> me
{'name': 'Marketa', 'city': 'Prague', 'numbers': [20, 8, 42]}
```

... or add keys and values:

```pycon
>>> me['language'] = 'Python'
>>> me
{'name': 'Marketa', 'city': 'Prague', 'numbers': [20, 8, 42], 'language': 'Python'}
```

... or delete keys and values using the `del` command (also the same as for lists):

```pycon
>>> del me['numbers']
>>> me
{'name': 'Marketa', 'city': 'Prague', 'language': 'Python'}
```

## Lookup table

A use of dictionaries other than data clustering is the
so-called *lookup table*.
It stores values of same type.

This is useful for example with phone book.
For every name there is one phone number.
Other examples are dictionaries with properties of food, or word translations.


```python
phones = {
    'Tyna': '153 85283',
    'Lubo': '237 26505',
    'Andreea': '385 11223',
    'Fabian': '491 88047',
    'Vitoria': '491 88047',
    'Oliwia': '491 88047',
}

colours = {
    'pear': 'green',
    'apple': 'red',
    'melon': 'green',
    'plum': 'purple',
    'radish': 'red',
    'cabbage': 'green',
    'carrot': 'orange',
}
```

Update Lubo's number to be the same as Fabian's as they now temporarily share phones

{% filter solution %}
```python
phones["Lubo"] = phones["Fabian"]
print(phones)
```
{% endfilter %}

## Iteration

When you loop over a dictionary using `for`, you will get only keys:

```pycon
>>> func_descript = {'len': 'length', 'str': 'string', 'dict': 'dictionary'}
>>> for key in func_descript:
...     print(key)
str
dict
len
```

If you want to access the values, you will have to use the method `values`:

```pycon
>>> for value in func_descript.values():
...     print(value)
string
dictionary
length
```

But in most cases, you will need both -- keys and values.
For this purpose, dictionaries have the method `items`. 

```pycon
>>> for key, value func_descript.items():
...     print('{}: {}'.format(key, value))
str: string
dict: dictionary
len: length
```



> [note]
> There is also the method `keys()` which return just keys.
>
> `keys()`, `values()` and `items()` return special objects
> which can be used in `for` loops (we say that those objects are "iterable"),
> and they behave as a set.
> This is well described in the [documentation](https://docs.python.org/3/library/stdtypes.html#dictionary-view-objects)

In a `for` loop, you can't add keys to dictionary nor delete them:

```pycon
>>> for key in func_descript:
...     del func_descript[key]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
RuntimeError: dictionary changed size during iteration
```

But you can change values for already existing keys.

Update the `phones` dictionary so that all numbers contain '+43' prefix

{% filter solution %}
```python
for person in phones:
    phones[person] = f'+43{phones[person]}'
print(phones)
```
{% endfilter %}


Using a for loop, ensure that following `keys` are deleted from the dictionary `phones`.
keys_to_delete = ['Lubo', 'Tyna', 'Oliwia']

{% filter solution %}
```python
for to_delete in keys_to_delete:
    # need to check if is present - can not delete a key which does not exist in dictionary
    if to_delete in phones:
        del phones[to_delete]
print(phones)
```
{% endfilter %}


## How to create a dictionary

Dictionaries can be created in two ways.
The first way uses curly brackets `{}`.
The other way is by using the keyword `dict`.
This works similar to `strings`, `integer` or `list`, so it will
convert some specific objects to a dictionary.

A dictionary has very specific structure --
numbers or simple lists can't be converted into a dictionary.
But we can convert a dictionary into *another dictionary*.
This new dictionary won't be in any way connected to the
old one.

```python
colour_riped = dict(colours)
for key in colour_riped:
    colour_riped[key] = 'blackish-brownish-' + colour_riped[key]
print(colours['apple'])
print(colour_riped['apple'])
```

We can also convert a list which contains tuples with *pairs* 
(which work as *key* and *value*) into a dictionary:

```python
data = [(1, 'one'), (2, 'two'), (3, 'three')]
number_names = dict(data)
```

And that's all that we can convert into a dictionary.

As a bonus function, `dict` can also work with named arguments.
Each argument's name will be a key and the argument itself will be the value:


```python
func_descript = dict(len='length', str='string', dict='dictionary')
print(func_descript['len'])
```

> [note]
> Be aware that in this case, keys have to have "pythonic" names –- 
> they must follow the same rules as other Python variables.
> For example, the following strings can't be keys: `"def"` or `"propan-butan"`.



We have this dictionary of computer access information of two users and another lookup table with cities information.
```python
users = {
  'aeinstein': {
    'first': 'albert',
    'last': 'einstein',
    'location': 'princeton',
    'email': 'albgenious1@princeton.org',
  },
  'mcurie': {
    'first': 'marie',
    'last': 'curie',
    'location': 'paris',
  },
}
 
cities = {
  'paris': {
    'country': 'France',
    'population': 2161,
  },
  'london': {
    'country': 'Great Britain',
    'population': 8960,
  },
  'princeton': {
    'country': 'United States of America',
    'population': 28,
  }
}
```
Print out following information about each user of they have it:
His/her 'username', 'full name' (first and last with first letter capitalized), 'email', 'city' they live in and 'country' they live in

{% filter solution %}
```python
for username, properties in users.items():
    fullname = f'{properties["first"][0].upper()}{ properties["first"][1:]} {properties["last"][0].upper()}{ properties["last"][1:]}'
    # or properties["first"].capitalize()
    if "email" in properties:
        email = properties["email"]
    else:
        email = None
    city = properties["location"]
    if properties["location"] in cities:
        country = cities[properties["location"]]["country"]
    else:
        country = None
    print(f'''
    User with username: "{username}"
    is named: "{fullname}",
    has email: "{email}",
    lives in "{city}",
    which is located in "{country}"
    ''')
```
{% endfilter %}



## And that's all for now

If you would like to know all the tricks
about dictionaries you can look at (and also print) this [cheatsheet](https://github.com/ehmatthes/pcc/releases/download/v1.0.0/beginners_python_cheat_sheet_pcc_dictionaries.pdf).

A complete description can be found here in the
Python [documentation](https://docs.python.org/3/library/stdtypes.html#mapping-types-dict).

