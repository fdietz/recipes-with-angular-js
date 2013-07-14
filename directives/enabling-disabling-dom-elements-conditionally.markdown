---
layout: recipe
title: Enabling/Disabling DOM Elements Conditionally
chapter: directives
order: 1
source_path: directives/source/recipe1
---

### Problem
You wish to disable a button depending on a checkbox state.

### Solution
Use the `ng-disabled` directive and bind its condition to the checkbox state.

{% prism markup %}
<body ng-app>
  <label><input type="checkbox" ng-model="checked"/>Toggle Button</label>
  <button ng-disabled="checked">Press me</button>
</body>
{% endprism %}

### Discussion
The `ng-disabled` directive is a direct translation from the disabled HTML attribute, without you needing to worry about browser incompatibilities. It is bound to the `checked` model using an attribute value as is the checkbox using the `ng-model` directive. In fact the `checked` attribute value is again an Angular expression. You could for example invert the logic and use `!checked` instead.

This is just one example of a directive shipped with Angular. There are many others like for example `ng-hide`, `ng-checked` or `ng-mouseenter` and I encourage you go through the [API Reference](http://docs.angularjs.org/api) and explore all the directives Angular has to offer.

In the next recipes we will focus on implementing directives.
