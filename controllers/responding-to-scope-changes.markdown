---
layout: recipe
title: Responding to Scope Changes
chapter: controllers
order: 4
source_path: controllers/source/recipe4
---

### Problem
You wish to react on a model change to trigger some further actions. In our example we simple want to set another model value depending on the value we are listening to.

### Solution
Use the `$watch` function in your controller.

{% prism javascript %}
function MyCtrl($scope) {
  $scope.name = "";

  $scope.$watch("name", function(newValue, oldValue) {
    if ($scope.name.length > 0) {
      $scope.greeting = "Greetings " + $scope.name;
    }
  });
}
{% endprism %}

In our example we use the text input value to print a friendly greeting.

{% prism markup %}
{% raw %}
<div ng-controller="MyCtrl">
  <input type="text" ng-model="name" placeholder="Enter your name">
  <p>{{greeting}}</p>
</div>
{% endraw %}
{% endprism %}

The value `greeting` will be changed whenever there's a change to the `name` model and the value is not blank.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter2/recipe4).

### Discussion
The first argument `name` of the `$watch` function is actually an Angular expression, so you can use more complex expressions (for example: `[value1, value2] | json`) or even a Javascript function. In this case you need to return a string in the watcher function:

{% prism javascript %}
$scope.$watch(function() {
  return $scope.name;
}, function(newValue, oldValue) {
  console.log("change detected: " + newValue)
});
{% endprism %}

The second argument is a function which gets called whenever the expression evaluation returns a different value. The first parameter is the new value and the second parameter the old value. Internally, this uses `angular.equals` to determine equality which means both objects or values pass the `===` comparison.

