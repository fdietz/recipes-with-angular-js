---
layout: recipe
title: Passing Configuration Params Using HTML Attributes
chapter: directives
order: 5
source_path: directives/source/recipe5
---

### Problem
You wish to pass a configuration param to change the rendered output.

### Solution
Use the attribute-based directive and pass an attribute value for the configuration. The attribute is passed as a parameter to the link function.

{% prism markup %}
<body ng-app="MyApp">
  <div my-widget="Hello World"></div>
</body>
{% endprism %}

{% prism javascript %}
var app = angular.module("MyApp", []);

app.directive("myWidget", function() {
  var linkFunction = function(scope, element, attributes) {
    scope.text = attributes["myWidget"];
  };

  return {
    restrict: "A",
    template: "<p>{{text}}</p>",
    link: linkFunction
  };
});
{% endprism %}

This renders a paragraph with the text passed as the param.

### Discussion
The link function has access to the element and its attributes. It is therefore straightforward to set the scope to the text passed as the attributes value and use this in the template evaluation.

The scope context is important though. The `text` model we changed might already be defined in the parent scope and used in another part of your app. In order to isolate the context and thereby use it only locally inside your directive, we have to return an additional scope attribute.

{% prism javascript %}
return {
  restrict: "A",
  template: "<p>{{text}}</p>",
  link: linkFunction,
  scope: {}
};
{% endprism %}

In Angular this is called an isolate scope. It does not prototypically inherit from the parent scope and is especially useful when creating reusable components.

Let's look into another way of passing params to the directive. This time we will define an HTML element `my-widget2`.

{% prism javascript %}
<my-widget2 text="Hello World"></my-widget2>

app.directive("myWidget2", function() {
  return {
    restrict: "E",
    template: "<p>{{text}}</p>",
    scope: {
      text: "@text"
    }
  };
});
{% endprism %}

The scope definition using `@text` is binding the text model to the directive's attribute. Note that any changes to the parent scope `text` will change the local scope `text`, but not the other way around.

If you want instead to have a bi-directional binding between the parent scope and the local scope, you should use the `=` equality character:

{% prism javascript %}
scope: {
  text: "=text"
}
{% endprism %}

Changes to the local scope will also change the parent scope.

Another option would be to pass an expression as a function to the directive using the `&` character.

{% prism markup %}
<my-widget-expr fn="count = count + 1"></my-widget-expr>
{% endprism %}

{% prism javascript %}
app.directive("myWidgetExpr", function() {
  var linkFunction = function(scope, element, attributes) {
    scope.text = scope.fn({ count: 5 });
  };

  return {
    restrict: "E",
    template: "<p>{{text}}</p>",
    link: linkFunction,
    scope: {
      fn: "&fn"
    }
  };
});
{% endprism %}

We pass the attribute `fn` to the directive and since the local scope defines `fn` accordingly we can call the function in the `linkFunction` and pass in the expression arguments as a hash.
