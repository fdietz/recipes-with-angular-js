---
layout: recipe
title: Rendering a Directive's DOM Node Children
chapter: directives
order: 4
source_path: directives/source/recipe4
---

### Problem
Your widget uses the child nodes of the directive element to create a combined rendering.

### Solution
Use the `transclude` attribute together with the `ng-transclude` directive.

{% prism markup %}
<my-widget>
  <p>This is my paragraph text.</p>
</my-widget>
{% endprism %}

{% prism javascript %}
var app = angular.module("MyApp", []);

app.directive("myWidget", function() {
  return {
    restrict: "E",
    transclude: true,
    template: "<div ng-transclude><h3>Heading</h3></div>"
  };
});
{% endprism %}

This will render a `div` element containing an `h3` element and append the directive's child node with the paragraph element below.

### Discussion
In this context, transclusion refers to the inclusion of a part of a document into another document by reference. The `ng-transclude` attribute should be positioned depending on where you want your child nodes to be appended.
