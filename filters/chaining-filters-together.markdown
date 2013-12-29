---
layout: recipe
title: Chaining Filters together
chapter: filters
order: 5
source_path: filters/source/recipe5
---

### Problem
You wish to combine several filters to form a single result.

### Solution
Filters can be chained using the UNIX-like pipe syntax.

{% prism markup %}
{% raw %}
<body ng-app="MyApp">
  <ul ng-init="names = ['Peter', 'Anton', 'John']">
    <li ng-repeat="name in names | exclude:'Peter' | sortAscending ">
      <span>{{name}}</span>
    </li>
  </ul>
</body>
{% endraw %}
{% endprism %}

### Discussion
The pipe symbol (`|`) is used to chain multiple filters together. First we will start with the initial Array of names. After applying the `exclude` filter the Array contains only `['Anton', 'John']` and afterwards we will sort the names in ascending order.

I leave the implementation of the `sortAscending` filter as an exercise to the reader ;-)
