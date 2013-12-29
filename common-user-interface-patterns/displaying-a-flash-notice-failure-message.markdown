---
layout: recipe
title: Displaying a Flash Notice/Failure Message
chapter: common-user-interface-patterns
order: 5
source_path: common-user-interface-patterns/source/recipe5
---

### Problem
You wish to display a flash confirmation message after a user submitted a form successfully.

### Solution
In a web framework like Ruby on Rails, the form submit will lead to a redirect with the flash confirmation message, relying on the browser session. For our client-side approach we bind to route changes and manage a queue of flash messages.

In our example we use a home page with a form and on form submit we navigate to another page and show the flash message. We use the `ng-view` Directive and define the two pages as script tags here.

{% prism markup %}
{% raw %}
<body ng-app="MyApp" ng-controller="MyCtrl">

  <ul class="nav nav-pills">
    <li><a href="#/">Home</a></li>
    <li><a href="#/page">Next Page</a></li>
  </ul>

  <div class="alert" ng-show="flash.getMessage()">
    <b>Alert!</b>
    <p>{{flash.getMessage()}}</p>
  </div>

  <ng-view></ng-view>

  <script type="text/ng-template" id="home.html">
    <h3>Home</h3>

    <form ng-submit="submit(message)" class="form-inline">
      <input type="text" ng-model="message" autofocus>
      <button class="btn">Submit</button>
    </form>

  </script>

  <script type="text/ng-template" id="page.html">
    <h3>Next Page</h3>

  </script>

</body>
{% endraw %}
{% endprism %}

Note that the flash message just like the navigation is always shown but conditionally hidden depending on whether there is a flash message available.

The route definition defines the pages, nothing new here for us:

{% prism javascript %}
var app = angular.module("MyApp", []);

app.config(function($routeProvider) {
  $routeProvider.
    when("/home", { templateUrl: "home.html" }).
    when("/page", { templateUrl: "page.html" }).
    otherwise({ redirectTo: "/home" });
});
{% endprism %}

The interesting part is the `flash` service, which handles a queue of messages and listens for route changes to provide a message from the queue to the current page.

{% prism javascript %}
app.factory("flash", function($rootScope) {
  var queue = [];
  var currentMessage = "";

  $rootScope.$on("$routeChangeSuccess", function() {
    currentMessage = queue.shift() || "";
  });

  return {
    setMessage: function(message) {
      queue.push(message);
    },
    getMessage: function() {
      return currentMessage;
    }
  };
});
{% endprism %}

The controller handles the form submit and navigates to the other page.

{% prism javascript %}
app.controller("MyCtrl", function($scope, $location, flash) {
  $scope.flash = flash;
  $scope.message = "Hello World";

  $scope.submit = function(message) {
    flash.setMessage(message);
    $location.path("/page");
  }
});
{% endprism %}

The flash service is dependency-injected into the controller and made available to the scope since we want to use it in our template.

When you press the submit button you will be navigated to the other page and see the flash message. Note that using the navigation to go back and forth between pages doesn't show the flash message.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter8/recipe5).

### Discussion
The controller uses the `setMessage` function of the `flash` service and the service stores the message in an array called `queue`. When the controller then uses `$location` service to navigate the service `routeChangeSuccess` listener will be called and retrieves the message from the queue.

In the template we use `ng-show` to hide the div element with the flash messaging using `flash.getMessage()`.

Since this is a service it can be used anywhere in your code and it will show a flash message on the next route change.
