---
layout: recipe
title: Changing the DOM in response to user actions
chapter: directives
order: 2
source_path: directives/source/recipe2
---

### Problem
You wish to change the CSS of an HTML element on a mouse click and encapsulate this behavior in a reusable component.

### Solution
Implement a directive `my-widget` that contains an example paragraph of text we want to style.

{% prism markup %}
{% raw %}
<body ng-app="MyApp">
  <my-widget>
    <p>Hello World</p>
  </my-widget>
</body>
{% endraw %}
{% endprism %}

We use a link function in our directive implementation to change the CSS of the paragraph.

{% prism javascript %}
var app = angular.module("MyApp", []);

app.directive("myWidget", function() {
  var linkFunction = function(scope, element, attributes) {
    var paragraph = element.children()[0];
    $(paragraph).on("click", function() {
      $(this).css({ "background-color": "red" });
    });
  };

  return {
    restrict: "E",
    link: linkFunction
  };
});
{% endprism %}

When clicking on the paragraph the background color changes to red.

### Discussion
In the HTML document we use the new directive as an HTML element `my-widget`, which can be found in the Javascript code as `myWidget` again. The directive function returns a restriction and a link function.

The restriction means that this directive can only be used as an HTML element and not for example an HTML attribute. If you want to use it as an HTML attribute, change the `restrict` to return `A` instead. The usage would then have to be adapted to:

{% prism markup %}
<div my-widget>
  <p>Hello World</p>
</div>
{% endprism %}

Whether you use the attribute or element mechanism will depend on your use case. Generally speaking one would use the element mechanism to define a custom reusable component. The attribute mechanism would be used whenever you want to "configure" some element or enhance it with more behavior. Other available options are using the directive as a class attribute or a comment.

The `directive` method expects a function that can be used for initialization and injection of dependencies.

{% prism javascript %}
app.directive("myWidget", function factory(injectables) {
  // ...
}
{% endprism %}

The link function is much more interesting since it defines the actual behavior. The scope, the actual HTML element `my-widget` and the HTML attributes are passed as params. Note that this has nothing to do with Angular's dependency injection mechanism. Ordering of the parameters is important!

Firstly we select the paragraph element, which is a child of the `my-widget` element using Angular's `children()` function as defined by element. In the second step we use jQuery to bind to the click event and modify the css property on click. This is of particular interest since we have a mixture of Angular element functions and jQuery here. In fact under the hood Angular will use jQuery in the `children()` function if it is defined and will fall back to jqLite (shipped with Angular) otherwise. You can find all supported methods in the [API Reference of element](http://docs.angularjs.org/api/angular.element).

Following a slightly altered version of the code using jQuery only:

{% prism javascript %}
element.on("click", function() {
  $(this).css({ "background-color": "red" });
});
{% endprism %}

In this case `element` is alreay a jQuery element and we can directly use the `on` function.

