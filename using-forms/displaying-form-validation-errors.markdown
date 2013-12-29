---
layout: recipe
title: Displaying Form Validation Errors
chapter: using-forms
order: 3
source_path: using-forms/source/recipe3
---

### Problem
You wish to show validation errors to the user by marking the input field red and displaying an error message.

### Solution
We can use the `ng-show` directive to show an error message if a form input is invalid and CSS classes to change the input element's background color depending on its state.

Let us start with the styling changes:

{% prism markup %}
{% raw %}
<style type="text/css">
  input.ng-invalid.ng-dirty {
    background-color: red;
  }
  input.ng-valid.ng-dirty {
    background-color: green;
  }
</style>
{% endraw %}
{% endprism %}

And here is a small part of the form with an error message for the input field:

{% prism markup %}
{% raw %}
<label>Firstname</label>
<input name="firstname" type="text" ng-model="user.firstname" required/>
<p ng-show="form.firstname.$invalid && form.firstname.$dirty">
  Firstname is required
</p>
{% endraw %}
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter7/recipe3).

### Discussion
The CSS classes ensure that we initially show the fresh form without any classes. When the user starts typing in some input for the first time, we change it to either green or red. That is a good example of using the `ng-dirty` and `ng-invalid` CSS classes.

We use the same logic in the `ng-show` directive to only show the error message when the user starts typing for the first time.
