---
layout: recipe
title: Requesting JSON data with AJAX
chapter: consuming-external-services
order: 1
source_path: consuming-external-services/source/recipe1
---

### Problem
You wish to fetch JSON data via AJAX request and render it.

### Solution
Implement a controller using the `$http` service to fetch the data and store it in the scope.

{% prism markup %}
{% raw %}
<body ng-app="MyApp">
  <div ng-controller="PostsCtrl">
    <ul ng-repeat="post in posts">
      <li>{{post.title}}</li>
    </ul>
  </div>
</body>
{% endraw %}
{% endprism %}

{% prism javascript %}
var app = angular.module("MyApp", []);

app.controller("PostsCtrl", function($scope, $http) {
  $http.get('data/posts.json').
    success(function(data, status, headers, config) {
      $scope.posts = data;
    }).
    error(function(data, status, headers, config) {
      // log error
    });
});
{% endprism %}

You can find the complete example using the angular-seed project on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter5/recipe1).

### Discussion
The controller defines a dependency to the `$scope` and the `$http` module. An HTTP GET request to the `data/posts.json` endpoint is carried out with the `get` method. It returns a [$promise](http://docs.angularjs.org/api/ng.$q) object with a `success` and an `error` method. Once successful, the JSON data is assigned to `$scope.posts` to make it available in the template.

The `$http` service supports the HTTP verbs `get`, `head`, `post`, `put`, `delete` and `jsonp`. We are going to look into more examples in the following chapters.

The `$http` service automatically adds certain HTTP headers like for example `X-Requested-With: XMLHttpRequest`. But you can also set custom HTTP headers by yourself using the `$http.defaults` function:

{% prism javascript %}
$http.defaults.headers.common["X-Custom-Header"] = "Angular.js"
{% endprism %}

Until now the `$http` service does not really look particularly special. But if you look into the [documentation](http://docs.angularjs.org/api/ng.$http) you find a whole lot of nice features like, for example, request/response transformations, to automatically deserialize JSON for you, response caching, response interceptors to handle global error handling, authentication or other preprocessing tasks and, of course, promise support. We will look into the `$q` service, Angular's promise/deferred service in a later chapter.
