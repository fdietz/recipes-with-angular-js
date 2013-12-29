---
layout: recipe
title: Listening on Route Changes to Implement a Login Mechanism
chapter: urls-routing-and-partials
order: 4
source_path: urls-routing-and-partials/source/recipe4
---

### Problem
You wish to ensure that a user has to login before navigating to protected pages.

### Solution
Implement a listener on the `$routeChangeStart` event to track the next route navigation. Redirect to a login page if the user is not yet logged in.

The most interesting part is the implementation of the route change listener:

{% prism javascript %}
var app = angular.module("MyApp", []).
  config(function($routeProvider, $locationProvider) {
    $routeProvider.
      when("/persons",
        { templateUrl: "partials/index.html" }).
      when("/login",
        { templateUrl: "partials/login.html", controller: "LoginCtrl" }).
      // event more routes here ...
      otherwise( { redirectTo: "/persons" });
  }).
  run(function($rootScope, $location) {
    $rootScope.$on( "$routeChangeStart", function(event, next, current) {
      if ($rootScope.loggedInUser == null) {
        // no logged user, redirect to /login
        if ( next.templateUrl === "partials/login.html") {
        } else {
          $location.path("/login");
        }
      }
    });
  });
{% endprism %}

Next we will define a login form to enter the username, skipping the password for the sake of simplicity:

{% prism markup %}
{% raw %}
<form ng-submit="login()">
  <label>Username</label>
  <input type="text" ng-model="username">
  <button>Login</button>
</form>
{% endraw %}
{% endprism %}

and finally the login controller, which sets the logged in user and redirects to the persons URL:

{% prism javascript %}
app.controller("LoginCtrl", function($scope, $location, $rootScope) {
  $scope.login = function() {
    $rootScope.loggedInUser = $scope.username;
    $location.path("/persons");
  };
});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter6/recipe4).

### Discussion
This is of course not a fully fledged login system so please don't use it in any production system. But, it exemplifies how to generally handle access to specific areas of your web app. When you open the app in your browser you will be redirected to the login app in all cases. Only after you have entered a username can you access the other areas.

The `run` method is defined in [Module](http://docs.angularjs.org/api/angular.Module) and is a good place for such a route change listener since it runs only once on initialization after the injector is finished loading all the modules. We check the `loggedInUser` in the `$rootScope` and if it is not set we redirect the user to the login page. Note that in order to skip this behavior when already navigating to the login page, we have to explicitly check the next `templateUrl`.

The login controller sets the `$rootScope` to the username and redirects to `/persons`. Generally, I try to avoid using the `$rootScope` since it basically is a kind of global state but in our case it fits nicely since there should be a current user globally available.