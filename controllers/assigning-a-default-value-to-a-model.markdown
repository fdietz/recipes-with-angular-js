---
layout: recipe
title: Assigning a Default Value to a Model
chapter: controllers
source_path: controllers/source/recipe1
order: 1
---

### Problem
You wish to assign a default value to the scope in the controller's context.

### Solution

Use the `ng-controller` directive in your template:

{% prism markup %}
{% raw %}
<div ng-controller="MyCtrl">
  <p>{{value}}</p>
</div>
{% endraw %}
{% endprism %}

Next, define the scope variable in your controller function:

{% prism javascript %}
var MyCtrl = function($scope) {
  $scope.value = "some value";
};
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter2/recipe1).

### Discussion
Depending on where you use the ng-controller directive, you define its assigned scope. The scope is hierarchical and follows the DOM node hierarchy. In our example, the value expression is correctly evaluated to `some value`, since value is set in the `MyCtrl` controller. Note that this would not work if the value expression were moved outside the controllers scope:

{% prism markup %}
{% raw %}
<p>{{value}}</p>

<div ng-controller="MyCtrl">
</div>
{% endraw %}
{% endprism %}

In this case {% raw %}{{value}}{% endraw %} will simply be not rendered at all due to the fact that expression evaluation in Angular.js is forgiving for `undefined` and `null` values.