---
layout: recipe
title: Rendering an HTML Snippet in a Directive
chapter: directives
order: 3
source_path: directives/source/recipe3
---

### Problem
You wish to render an HTML snippet as a reusable component.

### Solution
Implement a directive and use the `template` attribute to define the HTML.

{% prism markup %}
<body ng-app="MyApp">
  <my-widget/>
</body>
{% endprism %}

{% prism javascript %}
var app = angular.module("MyApp", []);

app.directive("myWidget", function() {
  return {
    restrict: "E",
    template: "<p>Hello World</p>"
  };
});
{% endprism %}

### Discussion
This will render the Hello World paragraph as a child node of your `my-widget` element. If you want to replace the element entirely with the paragraph you will also have to return the `replace` attribute:

{% prism javascript %}
app.directive("myWidget", function() {
  return {
    restrict: "E",
    replace: true,
    template: "<p>Hello World</p>"
  };
});
{% endprism %}

Another option would be to use a file for the HTML snippet. In this case you will need to use the `templateUrl` attribute, for example as follows:

{% prism javascript %}
app.directive("myWidget", function() {
  return {
    restrict: "E",
    replace: true,
    templateUrl: "widget.html"
  };
});
{% endprism %}

The `widget.html` should reside in the same directory as the `index.html` file. This will only work if you use a web server to host the file. The example on Github uses angular-seed as bootstrap again.
