---
layout: recipe
title: Implementing a Basic Form
chapter: using-forms
order: 1
source_path: using-forms/source/recipe1
---

### Problem
You wish to create a form to enter user details and capture this information in an Angular.js scope.

### Solution
Use the standard `form` tag and the `ng-model` directive to implement a basic form:

    <body ng-app="MyApp">
      <div ng-controller="User">
        <form ng-submit="submit()" class="form-horizontal" novalidate>
          <label>Firstname</label>
          <input type="text" ng-model="user.firstname"/>
          <label>Lastname</label>
          <input type="text" ng-model="user.lastname"/>
          <label>Age</label>
          <input type="text" ng-model="user.age"/>
          <button class="btn">Submit</button>
        </form>
      </div>
    </body>

The `novalidate` attribute disables the HTML5 validations, which are client-side validations supports by modern browsers. In our example we only want the Angular.js validations running to have complete control over the look and feel.

The controller binds the form data to your user model and implements the `submit()` function:

    var app = angular.module("MyApp", []);

    app.controller("User", function($scope) {
      $scope.user = {};
      $scope.wasSubmitted = false;

      $scope.submit = function() {
        $scope.wasSubmitted = true;
      };
    });

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter7/recipe1).

### Discussion
The initial idea when using forms would be to implement them in the traditional way by serialising the form data and submit it to the server. Instead we use `ng-model` to bind the form to our model, something we have been doing a lot already in previous recipes.

The submit button state is reflected in our `wasSubmitted` scope variable, but no submit to the server was actually done. The default behavior in Angular.js forms is to prevent the default action since we do not want to reload the whole page. We want to handle the submission in an application-specific way. In fact there is even more going on in the background and we are going to look into the behavior of the `form` or `ng-form` directive in the next recipe.
