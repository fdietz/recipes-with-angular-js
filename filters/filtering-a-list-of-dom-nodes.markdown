---
layout: recipe
title: Filtering a List of DOM Nodes
chapter: filters
order: 4
source_path: filters/source/recipe4
---

### Problem
You wish to filter a `ul` list of names.

### Solution
As well as with strings as input, Angular's filters also work with arrays.

{% prism markup %}
{% raw %}
<body ng-app="MyApp">
  <ul ng-init="names = ['Peter', 'Anton', 'John']">
    <li ng-repeat="name in names | exclude:'Peter' ">
      <span>{{name}}</span>
    </li>
  </ul>
</body>
{% endraw %}
{% endprism %}

{% prism javascript %}
var app = angular.module("MyApp", []);

app.filter("exclude", function() {
  return function(input, exclude) {
    var result = [];
    for (var i=0; i<input.length; i++) {
      if (input[i] !== exclude) {
        result.push(input[i]);
      }
    }

    return result;
  };
});
{% endprism %}

We pass `Peter` as the single param to the exclude filter, which will render all names except `Peter`.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter4/recipe4).

### Discussion
The filter implementation loops through all names and creates a result array excluding 'Peter'. Note that the actual syntax of the filter function didn't change at all from our previous example with the String input.
