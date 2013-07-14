---
layout: recipe
title: Repeatedly Rendering Directive's DOM Node Children
chapter: directives
order: 6
source_path: directives/source/recipe6
---

### Problem
You wish to render an HTML snippet repeatedly using the directive's child nodes as the "stamp" content.

### Solution
Implement a compile function in your directive.

{% prism markup %}
<repeat-ntimes repeat="10">
  <h1>Header 1</h1>
  <p>This is the paragraph.</p>
</repeat-n-times>
{% endprism %}

{% prism javascript %}
var app = angular.module("MyApp", []);

app.directive("repeatNtimes", function() {
  return {
    restrict: "E",
    compile: function(tElement, attrs) {
      var content = tElement.children();
      for (var i=1; i<attrs.repeat; i++) {
        tElement.append(content.clone());
      }
    }
  };
});
{% endprism %}

This will render the header and paragraph 10 times.

### Discussion
The directive repeats the child nodes as often as configured in the `repeat` attribute. It works similarly to the [ng-repeat](http://docs.angularjs.org/api/ng.directive:ngRepeat) directive. The implementation uses Angular's element methods to append the child nodes in a for loop.

Note that the compile method only has access to the templates element `tElement` and template attributes. It has no access to the scope and you therefore can't use `$watch` to add behavior either. This is in comparison to the link function that has access to the DOM "instance" (after the compile phase) and has access to the scope to add behavior.

Use the compile function for template DOM manipulation only. Use the link function whenever you want to add behavior.

Note that you can use both compile and link function combined. In this case the compile function must return the link function. As an example you want to react to a click on the header:

{% prism javascript %}
compile: function(tElement, attrs) {
  var content = tElement.children();
  for (var i=1; i<attrs.repeat; i++) {
    tElement.append(content.clone());
  }

  return function (scope, element, attrs) {
    element.on("click", "h1", function() {
      $(this).css({ "background-color": "red" });
    });
  };
}
{% endprism %}

Clicking the header will change the background color to red.
