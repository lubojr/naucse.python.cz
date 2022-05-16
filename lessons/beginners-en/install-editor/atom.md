{% set editor_name = 'Atom' %}
{% set editor_url = 'https://atom.io' %}
{% extends lesson.slug + '/_base.md' %}

{% block name_gen %} Atom {% endblock %}

{% block setup %}

You don't have to set up anything in Atom.

Indentation and colouring, how we want it, works only with files with `.py`
extension.

So it's better if you save your file as early as possible.

{% endblock %}
