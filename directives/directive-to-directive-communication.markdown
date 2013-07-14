---
layout: recipe
title: Directive-to-Directive Communication
chapter: directives
order: 7
source_path: directives/source/recipe7
---

### Problem
You wish a directive to communicate with another directive and augment each other's behavior using a well-defined interface (API).

### Solution
We implement a directive `basket` with a controller function and two other directive `orange` and `apple` which "require" this controller. Our example starts with an `apple` and `orange` directive used as attributes.

{% prism markup %}
<body ng-app="MyApp">
  <basket apple orange>Roll over me and check the console!</basket>
</body>
{% endprism %}

The `basket` directive manages an array to which one can add apples and oranges!

{% prism javascript %}
var app = angular.module("MyApp", []);

app.directive("basket", function() {
  return {
    restrict: "E",
    controller: function($scope, $element, $attrs) {
      $scope.content = [];

      this.addApple = function() {
        $scope.content.push("apple");
      };

      this.addOrange = function() {
        $scope.content.push("orange");
      };
    },
    link: function(scope, element) {
      element.bind("mouseenter", function() {
        console.log(scope.content);
      });
    }
  };
});
{% endprism %}

And finally the apple and orange directives, which add themselves to the basket using the basket's controller.

{% prism javascript %}
app.directive("apple", function() {
  return {
    require: "basket",
    link: function(scope, element, attrs, basketCtrl) {
      basketCtrl.addApple();
    }
  };
});

app.directive("orange", function() {
  return {
    require: "basket",
    link: function(scope, element, attrs, basketCtrl) {
      basketCtrl.addOrange();
    }
  };
});
{% endprism %}

If you hover with the mouse over the rendered text the console should print and the basket's content.

### Discussion
`Basket` is the example directive that demonstrates an API using the controller function, whereas the `apple` and `orange` directives augment the `basket` directive. They both define a dependency to the `basket` controller with the `require` attribute. The `link` function then gets `basketCtrl` injected.

Note how the `basket` directive is defined as an HTML element and the `apple` and `orange` directives are defined as HTML attributes (the default for directives). This demonstrates the typical use case of a reusable component augmented by other directives.

Now there might be other ways of passing data back and forth between directives - we have seen the different semantics of using the (isolated) context in directives in previous recipes - but what's especially great about the controller is the clear API contract it lets you define.