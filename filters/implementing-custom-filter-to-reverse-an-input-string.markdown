---
layout: recipe
title: Implementing a Custom Filter to Reverse an Input String
chapter: filters
order: 2
source_path: filters/source/recipe2
---

### Problem
You wish to reverse user's text input.

### Solution
Implement a custom filter, which reverses the input.

{% prism markup %}
{% raw %}
<body ng-app="MyApp">
  <input type="text" ng-model="text" placeholder="Enter text"/>
  <p>Input: {{ text }}</p>
  <p>Filtered input: {{ text | reverse }}</p>
</body>
{% endraw %}
{% endprism %}

{% prism javascript %}
var app = angular.module("MyApp", []);

app.filter("reverse", function() {
  return function(input) {
    var result = "";
    input = input || "";
    for (var i=0; i<input.length; i++) {
      result = input.charAt(i) + result;
    }
    return result;
  };
});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter4/recipe2).

### Discussion
Angular's filter function expects a filter name and a function as params. The function must return the actual filter function where you implement the business logic. In this example it will only have an `input` param. The result will be returned after the for loop has reversed the input.
