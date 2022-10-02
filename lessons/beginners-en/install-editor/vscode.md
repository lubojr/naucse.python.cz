{% set editor_name = 'VSCode' %}
{% set editor_url = 'https://code.visualstudio.com/' %}
{% extends lesson.slug + '/_base.md' %}

{% block name_gen %} VSCode {% endblock %}

{% block setup %}

For beginners course, you should install `Python extension` for VS Code.

When you open the VS Code, on the left side bar, choose the `Extensions` (Ctrl + Shift + X) with icon of four cubes.

Next, in the top search bar of Extensions, search for `Python` and in the list of extensions, which appears, select and install the first suggested package: `Python` - authored by Microsoft. You can install the package by clicking the small button `Install` placed in the bottom of the item in the list or after clicking the item in the newly opened panel and on top of the page, there should be a small button `install`.


> [note]
> Automatic indentation and desired code colouring (for our purposes) works only when the file has a `.py` extension.
> So it's better if you save your newly created file ending with `.py` as early as possible.

{% endblock %}
