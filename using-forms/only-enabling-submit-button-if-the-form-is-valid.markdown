---
layout: recipe
title: Only Enabling the Submit Button if the Form is Valid
chapter: using-forms
order: 5
source_path: using-forms/source/recipe5
---

### Problem
You wish to disable the Submit button as long as the form contains invalid data.

### Solution
Use the `$form.invalid` state in combination with a `ng-disabled` directive.

Here is the changed submit button:

{% prism markup %}
{% raw %}
<button ng-disabled="form.$invalid" class="btn">Submit</button>
{% endraw %}
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter7/recipe5).

### Discussion
The Form Controller attributes `form.$invalid` and friends are very useful to cover all kinds of use cases which focus on the form as a whole instead of individual fields.

Note that you have to assign a `name` attribute to the form element, otherwise `form.$invalid` won't be available.
