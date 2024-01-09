# JSON

There are also other programming languages ​​than Python.

Other languages ​​can not work with Python code.
If you would like to "talk" with such programs -
pass them some processing information
or to get results from them -
you have to pass the information in a simplified form.


## Types

Most programming languages ​​have some numbers, some sort of lists,
a variety of strings and some variation of dictionaries
(or several ways to create dictionaries).
And they have a way how to write `True`, `False` and `None`.

These basic types are usually sufficient for information handover
in a legible form, although there are not the exact equivalents in all languages
(Python has two basic types of numbers - `int` and` float`).
So we will focus on them.


## Data encoding

Another problem is data transfer:
so for you to be able to write data on disk or transfer
via the Internet, it has to be converted to a sequence of *bytes* (numbers from 0 to 255).
Simplified: you have to convert it to a string.

There are plenty of ways to encode data into text.
Each way is trying to find the right balance between
legibility for people/computers, length of record,
security, options and extensibility.
We already know the syntax for Python:

```python
{
    'name': 'Anna',
    'city': 'Prague',
    'languages': ['Czech', 'English', 'Python'],
    'age': 26,
}
```

Another way to write data is [YAML](http://www.yaml.org/):

```yaml
name: Anna
city: Prague
languages:
   - Czech
   - English
   - Python
age: 26
```

Finally, there is also [JSON](http://json.org/)
(*Javascript Object Notation*),
which, for its simplicity, has expanded the most:

```json
{
  "Name": "Anna",
  "City": "Prague",
  "Languages": ["Czech", "English", "Python"],
  "Age": 26
}
```

> [note]
> Keep in mind that although JSON looks similar to code
> in Python, it's another format with its own rules.
> Do not confuse them!
>
> At first I do not recommend writing JSON manually;
> let computer decide where to write
> commas and quotation marks.

## JSON in Python

Object encoding in JSON is simple: there is a `json` module,
whose `loads` method retrieves data from the string:

```python
import json

json_string = """
    {
      "name": "Anna",
      "city": "Brno",
      "languages": ["Czech", "English", "Python"],
      "age": 26
    }
"""

data = json.loads(json_string)
print(data)
print(data['city'])
```

And then there is the `dumps` method, which decodes the given data
and returns a string.

The string that `dumps(data)` returns is suitable for computer
treatment.
If you want to read it, it is better to set `ensure_ascii = False` 
(so that accented letters are not encoded with`\`)
and `indent = 2` (indent with two spaces).

```pycon
>>> print(json.dumps(data, ensure_ascii = False, indent = 2))
{
  "name": "Anna",
  "city": "Brno",
  "languages": [
    "Czech",
    "English",
    "Python"
  ],
  "age": 26
}
```
## Exercise

Write code to print the value of salary of Emma from following JSON string.

Try not to depend on the fact that her entry is first in the list)


```python
sampleJson = """{
  "company":{
    "employees":[
      {
        "name":"emma",
        "payable":{
          "salary":7000,
          "bonus":800
        }
      },
      {
        "name":"anna",
        "payable":{
          "salary":5500,
          "bonus":1000
        }
      }
    ]
  }
}"""
```

{% filter solution %}
```python
import json

sampleJson = """{
  "company":{
    "employees":[
      {
        "name":"emma",
        "payable":{
          "salary":7000,
          "bonus":800
        }
      },
      {
        "name":"anna",
        "payable":{
          "salary":5500,
          "bonus":1000
        }
      }
    ]
  }
}"""
content = json.loads(sampleJson)
employees = content.get("company", {}).get("employees", [])
for employee in employees:
    name = employee.get('name')
    if name == "emma":
      payable = employee.get("payable", {})
      total = payable.get("salary", 0) + payable.get("bonus", 0)
      print(f"{name} has a total salary with bonus: {total}")
```
{% endfilter %}


A complete description of `json` module -
including write/read functions directly to/from files -
is in the [documentation](https://docs.python.org/3/library/json.html).
