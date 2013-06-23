---
layout: recipe
title: Encapsulating a Model Value with a Controller Function
chapter: controllers
order: 3
---

### Problem
You wish to retrieve a model via function (instead of directly accessing the scope from the template) that encapsulates the model value.

### Solution
Define a getter function that returns the model value.

{% prism javascript %}
function MyCtrl($scope) {
  $scope.value = 1;

  $scope.getIncrementedValue = function() {
    return $scope.value + 1;
  };
}
{% endprism %}

Then in the template we use an expression to call it:

{% prism markup %}
{% raw %}
<div ng-controller="MyCtrl">
  <p>{{getIncrementedValue()}}</p>
</div>
{% endraw %}
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter2/recipe3).

### Discussion
`MyCtrl` defines the `getIncrementedValue` function, which uses the current value and returns it incremented by one. One could argue that depending on the use case it would make more sense to use a filter. But there are use cases specific to the controllers behavior where a generic filter is not required.
