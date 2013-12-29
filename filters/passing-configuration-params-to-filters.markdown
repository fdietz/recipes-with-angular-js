---
layout: recipe
title: Passing Configuration Params to Filters
chapter: filters
order: 3
source_path: filters/source/recipe3
---

### Problem
You wish to make your filter customizable by introducing config params.

### Solution
Angular filters can be passed a hash of params which can be directly accessed in the filter function.

{% prism markup %}
{% raw %}
<body ng-app="MyApp">
  <input type="text" ng-model="text" placeholder="Enter text"/>
  <p>Input: {{ text }}</p>
  <p>Filtered input: {{ text | reverse: { suffix: "!"} }}</p>
</body>
{% endraw %}
{% endprism %}

{% prism javascript %}
var app = angular.module("MyApp", []);

app.filter("reverse", function() {
  return function(input, options) {
    input = input || "";
    var result = "";
    var suffix = options["suffix"] || "";

    for (var i=0; i<input.length; i++) {
      result = input.charAt(i) + result;
    }

    if (input.length > 0) result += suffix;

    return result;
  };
});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter4/recipe3).

### Discussion
The suffix `!` is passed as an option to the filter function and is appended to the output. Note that we check if an actual input exists since we don't want to render the suffix without any input.
