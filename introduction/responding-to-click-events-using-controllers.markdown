---
layout: recipe
title: Responding to Click Events using Controllers
chapter: introduction
order: 3
---
### Problem
You wish to hide an HTML element on button click.

### Solution
Use the `ng-hide` directive in conjunction with a controller to change the visibility status on button click.


{% prism markup %}
<html>
  <head>
    <script src="js/angular.js"></script>
    <script src="js/app.js"></script>
    <link rel="stylesheet" href="css/bootstrap.css">
  </head>
  <body ng-app>
    <div ng-controller="MyCtrl">
      <button ng-click="toggle()">Toggle</button>
      <p ng-show="visible">Hello World!</p>
    </div>
  </body>
</html>
{% endprism %}

And the controller in `js/app.js`:

{% prism javascript %}
function MyCtrl($scope) {
  $scope.visible = true;

  $scope.toggle = function() {
    $scope.visible = !$scope.visible;
  };
}
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter1/recipe3).

When toggling the button the "Hello World" paragraph will change its visibility.

### Discussion
Using the `ng-controller` directive, we bind the `div` element including its children to the context of the `MyCtrl` controller. The `ng-click` directive will call the `toggle()` function of our controller on button click. Note that the `ng-show` directive is bound to the `visible` scope variable and will toggle the paragraph's visibility accordingly.

The controller implementation defaults the `visible` attribute to true and toggles its Boolean state in the `toggle` function. Both the `visible` variable and the `toggle` function are defined on the `$scope` service which is passed to all controller functions automatically via dependency injection.

The next chapter will go into all the details of controllers in Angular. For now let us quickly discuss the MVVM (Model-View-ViewModel) pattern as used by Angular. In the MVVM pattern the model is plain Javascript, the view is the HTML template and the ViewModel is the glue between the template and the model. The ViewModel makes Angular's two-way binding possible where changes in the model or the template are in sync automatically.

In our example, the `visible` attribute is the model, but it could of course be much more complex , when for example retrieving data from a backend service. The controller is used to define the scope which represents the ViewModel. It interacts with the HTML template by binding the scope variable `visible` and the function `toggle()` to it.
