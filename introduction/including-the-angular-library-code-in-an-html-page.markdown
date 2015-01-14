---
layout: recipe
title: Including the Angular.js Library Code in an HTML Page
chapter: introduction
order: 1
source_path: introduction/source/recipe1
---
### Problem
You wish to use Angular.js on a web page.

### Solution
In order to get your first Angular.js app up and running you need to include the Angular Javascript file via `script` tag and make use of the `ng-app` directive.

{% prism markup %}
{% raw %}
<html>
  <head>
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.0.4/angular.js">
    </script>
  </head>
  <body ng-app>
    <p>This is your first angular expression: {{ 1 + 2 }}</p>
  </body>
</html>
{% endraw %}
{% endprism %}

### Discussion
Adding the `ng-app` directive tells Angular to kick in its magic. The expression `{{ 1 + 2 }}` is evaluated by Angular and the result `3` is rendered. Note that removing `ng-app` will result in the browser rendering the expression as is instead of evaluating it. Play around with the expression! You can, for instance, concatenate Strings and invert or combine Boolean values.
