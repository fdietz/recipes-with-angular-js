---
layout: recipe
title: Sharing Code Between Controllers using Services
chapter: controllers
order: 6
---

### Problem
You wish to share business logic between controllers.

### Solution
Utilise a [Service](http://docs.angularjs.org/guide/dev_guide.services) to implement your business logic and use dependency injection to use this service in your controllers.

The template shows access to a list of users from two controllers:

{% prism markup %}
{% raw %}
<div ng-controller="MyCtrl">
  <ul ng-repeat="user in users">
    <li>{{user}}</li>
  </ul>
  <div class="nested" ng-controller="AnotherCtrl">
    First user: {{firstUser}}
  </div>
</div>
{% endraw %}
{% endprism %}

The service and controller implementation in `app.js` implements a user service and the controllers set the scope initially:

{% prism javascript %}
var app = angular.module("MyApp", []);

app.factory("UserService", function() {
  var users = ["Peter", "Daniel", "Nina"];

  return {
    all: function() {
      return users;
    },
    first: function() {
      return users[0];
    }
  };
});

app.controller("MyCtrl", function($scope, UserService) {
  $scope.users = UserService.all();
});

app.controller("AnotherCtrl", function($scope, UserService) {
  $scope.firstUser = UserService.first();
});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter2/recipe6).

### Discussion
The `factory` method creates a singleton `UserService`, that returns two functions for retrieving all users and the first user only. The controllers get the `UserService` injected by adding it to the `controller` function as params.

Using dependency injection here is quite nice for testing your controllers, since you can easily inject a `UserService` stub. The only downside is that you can't minify the code from above without breaking it, since the injection mechanism relies on the exact string representation of `UserService`. It is therefore recommended to define dependencies using inline annotations, which keeps working even when minified:

{% prism javascript %}
app.controller("AnotherCtrl", ["$scope", "UserService",
  function($scope, UserService) {
    $scope.firstUser = UserService.first();
  }
]);
{% endprism %}

The syntax looks a bit funny, but since strings in arrays are not changed during the minification process it solves our problem. Note that you could change the parameter names of the function, since the injection mechanism relies on the order of the array definition only.

Another way to achieve the same is using the `$inject` annotation:

{% prism javascript %}
var anotherCtrl = function($scope, UserService) {
  $scope.firstUser = UserService.first();
};

anotherCtrl.$inject = ["$scope", "UserService"];
{% endprism %}

This requires you to use a temporary variable to call the `$inject` service. Again, you could change the function parameter names. You will most probably see both versions applied in apps using Angular.

