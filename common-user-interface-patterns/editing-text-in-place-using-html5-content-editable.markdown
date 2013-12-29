---
layout: recipe
title: Editing Text In-Place using HTML5 ContentEditable
chapter: common-user-interface-patterns
order: 6
source_path: common-user-interface-patterns/source/recipe6
---

### Problem
You wish to make a div element editable in place using the HTML5 contenteditable attribute.

### Solution
Implement a directive for the `contenteditable` attribute and use `ng-model` for data binding.

In this example we use a div and a paragraph to render the content.

{% prism markup %}
{% raw %}
<div contenteditable ng-model="text"></div>
<p>{{text}}</p>
{% endraw %}
{% endprism %}

The directive is especially interesting since it uses `ng-model` instead of custom attributes.

{% prism javascript %}
app.directive("contenteditable", function() {
  return {
    restrict: "A",
    require: "ngModel",
    link: function(scope, element, attrs, ngModel) {

      function read() {
        ngModel.$setViewValue(element.html());
      }

      ngModel.$render = function() {
        element.html(ngModel.$viewValue || "");
      };

      element.bind("blur keyup change", function() {
        scope.$apply(read);
      });
    }
  };
});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter8/recipe6).

### Discussion
The directive is restricted for usage as an HTML attribute since we want to use the HTML5 contenteditable attribute as it is instead of defining a new HTML element.

It requires the `ngModel` controller for data binding in conjunction with the link function. The implementation binds an event listener, which executes the `read` function with [apply](http://docs.angularjs.org/api/ng.$rootScope.Scope). This ensures that even though we call the `read` function from within a DOM event handler we notify Angular about it.

The `read` function updates the model based on the view's user input. And the `$render` function is doing the same in the other direction, updating the view for us whenever the model changes.

The directive is surprisingly simple, leaving the `ng-model` aside. But without the `ng-model` support we would have to come up with our own model-attribute handling which would not be consistent with other directives.
