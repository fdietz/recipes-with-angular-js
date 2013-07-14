---
layout: recipe
title: Converting Expression Output with Filters
chapter: introduction
order: 4
source_path: introduction/source/recipe4
---

### Problem
When presenting data to the user, you might need to convert the data to a more user-friendly format. In our case we want to uppercase the `name` value from the previous recipe in the expression.

### Solution
Use the `uppercase` Angular filter.

{% prism markup %}
{% raw %}
Enter your name: <input type="text" ng-model="name"></input>
<p>Hello {{name | uppercase }}!</p>
{% endraw %}
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter1/recipe4).

### Discussion
Angular uses the `|` (pipe) character to combine filters with variables in expressions. When evaluating the expression, the name variable is passed to the uppercase filter. This is similar to working with the Unix bash pipe symbol where an input can be transformed by another program. Also try the `lowercase` filter!

