---
layout: recipe
title: Displaying Form Validation Errors with the Twitter Bootstrap framework
chapter: using-forms
order: 4
source_path: using-forms/source/recipe4
---

### Problem
You wish to display form validation errors but the form is styled using [Twitter Bootstrap](http://twitter.github.com/bootstrap/index.html).

### Solution
When using the `.horizontal-form` class Twitter Bootstrap uses `div` elements to structure label, input fields and help messages into groups. The group div has the class `control-group` and the actual controls are further nested in another `div` element with the CSS class `controls`. Twitter Bootstrap shows a nice validation status when adding the CSS class `error` on the div with the `control-group` class.

Let us start with the form:

{% prism markup %}
{% raw %}
<div ng-controller="User">
  <form name="form" ng-submit="submit()" novalidate>

    <div class="control-group" ng-class="error('firstname')">
      <label class="control-label" for="firstname">Firstname</label>
      <div class="controls">
        <input id="firstname" name="firstname" type="text"
          ng-model="user.firstname" placeholder="Firstname" required/>
        <span class="help-block"
          ng-show="form.firstname.$invalid && form.firstname.$dirty">
          Firstname is required
        </span>
      </div>
    </div>

    <div class="control-group" ng-class="error('lastname')">
      <label class="control-label" for="lastname">Lastname</label>
      <div class="controls">
        <input id="lastname" name="lastname" type="text"
          ng-model="user.lastname" placeholder="Lastname" required/>
        <span class="help-block"
          ng-show="form.lastname.$invalid && form.lastname.$dirty">
          Lastname is required
        </span>
      </div>
    </div>

    <div class="control-group">
      <div class="controls">
        <button ng-disabled="form.$invalid" class="btn">Submit</button>
      </div>
    </div>
  </form>
</div>
{% endraw %}
{% endprism %}

Note that we use the `ng-class` directive on the `control-group` div. So let's look at the controller implementation of the `error` function:

{% prism javascript %}
app.controller("User", function($scope) {
  // ...
  $scope.error = function(name) {
    var s = $scope.form[name];
    return s.$invalid && s.$dirty ? "error" : "";
  };
});
{% endprism %}

The error function gets the input name attribute passed as a string and checks for the `$invalid` and `$dirty` flags to return either the error class or a blank string.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter7/recipe4).

### Discussion
Again we check both the invalid and dirty flags because we only show the error message in case the user has actually changed the form. Note that this `ng-class` function usage is pretty typical in Angular since expressions do not support ternary checks.
