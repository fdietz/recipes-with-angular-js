---
layout: recipe
title: Implementing Custom Validations
chapter: using-forms
order: 6
source_path: using-forms/source/recipe6
---

### Problem
You wish to validate user input by comparing it to a blacklist of words.

### Solution
The [angular-ui](http://angular-ui.github.com/) project offers a nice custom validation directive which lets you pass in options via expression.

Let us have a look at the template first with the usage of the `ui-validate` Directive:

{% prism markup %}
{% raw %}
<input name="firstname" type="text"
  ng-model="user.firstname" required
  ui-validate=" { blacklisted: 'notBlacklisted($value)' } "
/>

<p ng-show='form.firstname.$error.blackListed'>
  This firstname is blacklisted.
</p>
{% endraw %}
{% endprism %}

And the controller with the `notBlackListed` implementation:

{% prism javascript %}
var app = angular.module("MyApp", ["ui", "ui.directives"]);

app.controller("User", function($scope) {
  $scope.blacklist = ['idiot','loser'];

  $scope.notBlackListed = function(value) {
    return $scope.blacklist.indexOf(value) === -1;
  };
});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter7/recipe6).

### Discussion
First we need to explicitly list our module dependency to the Angular UI directives module. Make sure you actually download the javascript file and load it via script tag.

Our blacklist contains the words we do not want to accept as user input and the `notBlackListed` function checks if the user input matches any of the words defined in the blacklist.

The `ui-validate` directive is pretty powerful since it lets you define your custom validations easily by just implementing the business logic in a controller function.

If you want to know even more, have a look at how to implement custom directives for yourself in Angular's excellent [guide](http://docs.angularjs.org/guide/forms).
