---
layout: recipe
title: Validating a Form Model Client-Side
chapter: using-forms
order: 2
source_path: using-forms/source/recipe2
---

### Problem
You wish to validate the form client-side using HTML5 form attributes.

### Solution
Angular.js works in tandem with HTML5 form attributes. Let us start with the same form but let us add some HTML5 attributes to make the input required:

    <form name="form" ng-submit="submit()">
      <label>Firstname</label>
      <input name="firstname" type="text" ng-model="user.firstname" required/>
      <label>Lastname</label>
      <input type="text" ng-model="user.lastname" required/>
      <label>Age</label>
      <input type="text" ng-model="user.age"/>
      <br>
      <button class="btn">Submit</button>
    </form>

It is still the same form but this time we defined the `name` attribute on the form and made the input `required` for the firstname.

Let us add some more debug output below the form:

    Firstname input valid: {{form.firstname.$valid}}
    <br>
    Firstname validation error: {{form.firstname.$error}}
    <br>
    Form valid: {{form.$valid}}
    <br>
    Form validation error: {{form.$error}}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter7/recipe2).

### Discussion
When starting with a fresh empty form, you will notice that Angular adds the css class `ng-pristine` and `ng-valid` to the form tag and each input tag. When editing the form the `ng-pristine` class will be removed from the changed input field and also from the form tag. Instead it will be replaced by the `ng-dirty` class. Very useful because it allows you to easily add new features to your app depending on these states.

In addition to these two css classes there are two more to look into. The `ng-valid` class will be added whenever an input is valid, otherwise the css class `ng-invalid` is added. Note that the form tag also gets either a valid or invalid class depending on the input fields. To demonstrate this I've added the `required` HTML5 attribute. Initially, the firstname and lastname input fields are empty and therefore have the `ng-invalid` css class, whereas the age input field has the `ng-valid` class. Additionally, there's `ng-invalid-required` class alongside the `ng-invalid` for even more specificity.

Since we defined the `name` attribute on the form HTML element we can now access Angular's form controller via scope variables. In the debug output we can check the validity and specific error for each named form input and the form itself. Note that this only works on the level of the form's name attributes and not on the model scope. If you output the following expression `{{user.firstname.$error}}` it will not work.

Angular's form controller exposes `$valid`, `$invalid`, `$error`, `$pristine` and `$dirty` variables.

For validation, Angular provides built-in directives including `required`, `pattern`, `minlength`, `maxlength`, `min` and `max`.

Let us use Angular's form integration to actually show validation errors in the next recipe.
