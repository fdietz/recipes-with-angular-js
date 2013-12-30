---
layout: recipe
title: Displaying a Loading Spinner
chapter: common-user-interface-patterns
order: 8
---

### Problem
You wish to display a loading spinner while waiting for an AJAX request to be finished.

### Solution
We will use the Twitter search API for our example to render a list of search results. When pressing the button the AJAX request is run and the spinner image should be shown until the request is done.

{% prism markup %}
{% raw %}
<body ng-app="MyApp" ng-controller="MyCtrl">

  <div>
    <button class="btn" ng-click="load()">Load Tweets</button>
    <img id="spinner" ng-src="img/spinner.gif" style="display:none;">
  </div>

  <div>
    <ul ng-repeat="tweet in tweets">
      <li>
        <img ng-src="{{tweet.profile_image_url}}" alt="">
        &nbsp; {{tweet.from_user}}
        {{tweet.text}}
      </li>
    </ul>
  </div>

</body>
{% endraw %}
{% endprism %}

An Angular.js interceptor for all AJAX calls is used, which allows you to execute code before the actual request is started and when it is finished.

{% prism javascript %}
var app = angular.module("MyApp", ["ngResource"]);

app.config(function ($httpProvider) {
  $httpProvider.responseInterceptors.push('myHttpInterceptor');

  var spinnerFunction = function spinnerFunction(data, headersGetter) {
    $("#spinner").show();
    return data;
  };

  $httpProvider.defaults.transformRequest.push(spinnerFunction);
});

app.factory('myHttpInterceptor', function ($q, $window) {
  return function (promise) {
    return promise.then(function (response) {
      $("#spinner").hide();
      return response;
    }, function (response) {
      $("#spinner").hide();
      return $q.reject(response);
    });
  };
});
{% endprism %}

Note that we use jQuery to show the spinner in the configuration step and hide the spinner in the interceptor.

Additionally we use a controller to handle the button click and execute the search request.

{% prism javascript %}
app.controller("MyCtrl", function($scope, $resource, $rootScope) {

  $scope.resultsPerPage = 5;
  $scope.page = 1;
  $scope.searchTerm = "angularjs";

  $scope.twitter = $resource('http://search.twitter.com/search.json',
    { callback:'JSON_CALLBACK',
      page: $scope.page,
      rpp: $scope.resultsPerPage,
      q: $scope.searchTerm },
    { get: { method:'JSONP' } });

  $scope.load = function() {
    $scope.twitter.get(function(data) {
      $scope.tweets = data.results;
    });
  };
});
{% endprism %}

Don't forget to add `ngResource` to the module and load it via script tag.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter8/recipe8).

### Discussion
The template is the easy part of this recipe since it renders a list of tweets using the `ng-repeat` directive. Let us jump straight to the interceptor code.

The interceptor is implemented using the factory method and attaches itself to the promise function of the AJAX response to hide the spinner on success or failure. Note that on failure we use the `reject` function of the [$q](http://docs.angularjs.org/api/ng.$q) service, Angular's promise/deferred implementation.

Now, in the `config` method we add our inceptor to the list of responseInterceptors of `$httpProvider` to register it properly. In a similar manner we add the `spinnerFunction` to the default `transformRequest` list in order to call it before each AJAX request.

The controller is responsible for using a `$resource` object and handling the button click with the `load` function. We are using JSONP here to allow this code to be executed locally even though it is served by a different domain.