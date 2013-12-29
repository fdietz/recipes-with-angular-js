---
layout: recipe
title: Filtering and Sorting a List
chapter: common-user-interface-patterns
order: 1
source_path: common-user-interface-patterns/source/recipe1
---

### Problem
You wish to filter and sort a relatively small list of items all available on the client.

### Solution
For this example we will render a list of friends using the `ng-repeat` directive. Using the built-in `filter` and `orderBy` filters we will filter and sort the friends list client-side.

{% prism markup %}
{% raw %}
<body ng-app="MyApp">
  <div ng-controller="MyCtrl">
    <form class="form-inline">
      <input ng-model="query" type="text"
        placeholder="Filter by" autofocus>
    </form>
    <ul ng-repeat="friend in friends | filter:query | orderBy: 'name' ">
      <li>{{friend.name}}</li>
    </ul>
  </div>
</body>
{% endraw %}
{% endprism %}

A plain text input field is used to enter the filter query and bound to the `filter`. Any changes are therefore directly used to filter the list.

The controller defines the default friends array:

{% prism javascript %}
app.controller("MyCtrl", function($scope) {
  $scope.friends = [
    { name: "Peter",   age: 20 },
    { name: "Pablo",   age: 55 },
    { name: "Linda",   age: 20 },
    { name: "Marta",   age: 37 },
    { name: "Othello", age: 20 },
    { name: "Markus",  age: 32 }
  ];
});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter8/recipe1).

### Discussion
Chaining filters is a fantastic way of implementing such a use case as long as you have all the data available on the client.

The [filter](http://docs.angularjs.org/api/ng.filter:filter) Angular.js Filter works on an array and returns a subset of items as a new array. It supports a String, Object or Function parameter. In this example we only use the String parameter, but given that the `$scope.friends` is an array of objects we could think of more complex examples where we use the Object param, as for example:

{% prism markup %}
{% raw %}
<ul ng-repeat="friend in friends |
  filter: { name: query, age: '20' } |
  orderBy: 'name' ">
  <li>{{friend.name}} ({{friend.age}})</li>
</ul>
{% endraw %}
{% endprism %}

That way we can filter by name and age at the same time. And lastly you could call a function defined in the controller, which does the filtering for you:

{% prism markup %}
{% raw %}
<ul ng-repeat="friend in friends |
  filter: filterFunction |
  orderBy: 'name' ">
  <li>{{friend.name}} ({{friend.age}})</li>
</ul>
{% endraw %}
{% endprism %}

{% prism javascript %}
$scope.filterFunction = function(element) {
  return element.name.match(/^Ma/) ? true : false;
};
{% endprism %}

The `filterFunction` must return either `true` or `false`. In this example we use a regular expression on the name starting with `Ma` to filter the list.
