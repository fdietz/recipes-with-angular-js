---
layout: recipe
title: Using Route Location to Implement a Navigation Menu
chapter: urls-routing-and-partials
order: 3
---

### Problem
You wish to implement a navigation menu, which shows the selected menu item to the user.

### Solution
Use the `$location` service in a controller to compare the address bar URL to the navigation menu item the user selected.

The navigation menu is the classic ul/li menu using a class attribute to mark one of the `li` elements as `active`:

{% prism markup %}
{% raw %}
<body ng-controller="MainCtrl">
  <ul class="menu">
    <li ng-class="menuClass('persons')"><a href="#!persons">Home</a></li>
    <li ng-class="menuClass('help')"><a href="#!help">Help</a></li>
  </ul>
  ...
</body>
{% endraw %}
{% endprism %}

The controller implements the `menuClass` function:

{% prism javascript %}
app.controller("MainCtrl", function($scope, $location) {
  $scope.menuClass = function(page) {
    var current = $location.path().substring(1);
    return page === current ? "active" : "";
  };
});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter6/recipe3).

### Discussion
When the user selects a menu item the client-side navigation will kick in as expected. The `menuClass` function is bound using the `ngClass` directive and updates the CSS class automatically for us depending on the current route.

Using `$location.path()` we get the current route. The `substring` operation removes the leading slash (`/`) and converts `/persons` to `persons`.
