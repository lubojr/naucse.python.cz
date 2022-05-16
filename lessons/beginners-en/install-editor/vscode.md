{% set editor_name = 'VSCode' %}
{% set editor_url = 'https://code.visualstudio.com/' %}
{% extends lesson.slug + '/_base.md' %}

{% block name_gen %} VSCode {% endblock %}

{% block setup %}

You don't have to set up anything in VSCode

Indentation and colouring, how we want it, works only with files with `.py`
extension.

So it's better if you save your file as early as possible.

{% endblock %}
