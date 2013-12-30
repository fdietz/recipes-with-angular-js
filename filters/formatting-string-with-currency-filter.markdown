---
layout: recipe
title: Formatting a String with currency Filter
chapter: filters
order: 1
---

### Problem
You wish to format the amount of currency with a localized currency label.

### Solution
Use the built-in `currency` filter and make sure you load the corresponding locale file for the user's language.

{% prism markup %}
{% raw %}
<html>
  <head>
    <meta charset='utf-8'>
    <script src="js/angular.js"></script>
    <script src="js/angular-locale_de.js"></script>
  </head>
  <body ng-app>
    <input type="text" ng-model="amount" placeholder="Enter amount"/>
    <p>Default Currency: {{ amount | currency }}</p>
    <p>Custom Currency: {{ amount | currency: "Euro" }}</p>
  </body>
</html>
{% endraw %}
{% endprism %}

Enter an amount and it will be displayed using Angular's default locale.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter4/recipe1).

### Discussion
In our example we explicitly load the German locale settings and therefore the default formatting will be in German. The English locale is shipped by default, so there's no need to include the angular-locale_en.js file. If you remove the script tag, you will see the formatting change to English instead. This means in order for a localized application to work correctly you need to load the corresponding locale file. All available locale files can be seen on [github](https://github.com/angular/angular.js/tree/master/src/ngLocale).
