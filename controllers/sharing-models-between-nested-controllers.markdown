---
layout: recipe
title: Sharing Models Between Nested Controllers
chapter: controllers
order: 5
source_path: controllers/source/recipe5
---

### Problem
You wish to share a model between a nested hierarchy of controllers.

### Solution
Use Javascript objects instead of primitives or direct `$parent` scope references.

Our example template uses a controller `MyCtrl` and a nested controller `MyNestedCtrl`:

{% prism markup %}
{% raw %}
<body ng-app="MyApp">
  <div ng-controller="MyCtrl">
    <label>Primitive</label>
    <input type="text" ng-model="name">

    <label>Object</label>
    <input type="text" ng-model="user.name">

    <div class="nested" ng-controller="MyNestedCtrl">
      <label>Primitive</label>
      <input type="text" ng-model="name">

      <label>Primitive with explicit $parent reference</label>
      <input type="text" ng-model="$parent.name">

      <label>Object</label>
      <input type="text" ng-model="user.name">
    </div>
  </div>
</body>
{% endraw %}
{% endprism %}

The `app.js` file contains the controller definition and initializes the scope with some defaults:

{% prism javascript %}
var app = angular.module("MyApp", []);

app.controller("MyCtrl", function($scope) {
  $scope.name = "Peter";
  $scope.user = {
    name: "Parker"
  };
});

app.controller("MyNestedCtrl", function($scope) {
});
{% endprism %}

Play around with the various input fields and see how changes affect each other.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter2/recipe5).

### Discussion
All the default values are defined in `MyCtrl` which is the parent of `MyNestedCtrl`. When making changes in the first input field, the changes will be in sync with the other input fields bound to the `name` variable. They all share the same scope variable as long as they only read from the variable. If you change the nested value, a copy in the scope of the `MyNestedCtrl` will be created. From now on, changing the first input field will only change the nested input field which explicitly references the parent scope via `$parent.name` expression.

The object-based value behaves differently in this regard. Whether you change the nested or the `MyCtrl` scopes input fields, the changes will stay in sync. In Angular, a scope prototypically inherits properties from a parent scope. Objects are therefore references and kept in sync. Whereas primitive types are only in sync as long they are not changed in the child scope.

Generally I tend to not use `$parent.name` and instead always use objects to share model properties. If you use `$parent.name` the `MyNestedCtrl` not only requires certain model attributes but also a correct scope hierarchy to work with.

Tip: The Chrome plugin [Batarang](https://github.com/angular/angularjs-batarang) simplifies debugging the scope hierarchy by showing you a tree of the nested scopes. It is awesome!

