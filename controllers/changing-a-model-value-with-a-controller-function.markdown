---
layout: recipe
title: Changing a Model Value with a Controller Function
chapter: controllers
order: 2
source_path: controllers/source/recipe2
---

### Problem
You wish to increment a model value by 1 using a controller function.

### Solution
Implement an increment function that changes the scope.

{% prism javascript %}
function MyCtrl($scope) {
  $scope.value = 1;

  $scope.incrementValue = function(increment) {
    $scope.value += increment;
  };
}
{% endprism %}

This function can be directly called in an expression, in our example we use `ng-init`:

{% prism markup %}
{% raw %}
<div ng-controller="MyCtrl">
  <p ng-init="incrementValue(1)">{{value}}</p>
</div>
{% endraw %}
{% endprism %}

### Discussion
The `ng-init` directive is executed on page load and calls the function `incrementValue` defined in `MyCtrl`. Functions are defined on the scope very similar to values but must be called with the familiar parenthesis syntax.

Of course, it would have been possible to increment the value right inside of the expression with `value = value +1` but imagine the function being much more complex! Moving this function into a controller separates our business logic from our declarative view template and we can easily write unit tests for it.