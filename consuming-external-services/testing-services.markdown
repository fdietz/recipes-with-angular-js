---
layout: recipe
title: Testing Services
chapter: consuming-external-services
order: 5
---

### Problem
You wish to unit test your controller and service consuming a JSONP API.

Let's have a look again at our example we wish to test:

{% prism javascript %}
var app = angular.module("MyApp", ["ngResource"]);

app.factory("TwitterAPI", function($resource) {
  return $resource("http://search.twitter.com/search.json",
    { callback: "JSON_CALLBACK" },
    { get: { method: "JSONP" }});
});

app.controller("MyCtrl", function($scope, TwitterAPI) {
  $scope.search = function() {
    $scope.searchResult = TwitterAPI.get({ q: $scope.searchTerm });
  };
});
{% endprism %}

Note that it slightly changed from the previous recipe as the `TwitterAPI` is pulled out of the controller and resides in its own service now.

### Solution
Use the angular-seed project and the $http_backend mocking service.

{% prism javascript %}
describe('MyCtrl', function(){
  var scope, ctrl, httpBackend;

  beforeEach(module("MyApp"));

  beforeEach(
    inject(
      function($controller, $rootScope, TwitterAPI, $httpBackend) {
        httpBackend = $httpBackend;
        scope = $rootScope.$new();
        ctrl = $controller("MyCtrl", {
          $scope: scope, TwitterAPI: TwitterAPI });

        var mockData = { key: "test" };
        var url = "http://search.twitter.com/search.json?" +
          "callback=JSON_CALLBACK&q=angularjs";
        httpBackend.whenJSONP(url).respond(mockData);
      }
    )
  );

  it('should set searchResult on successful search', function() {
    scope.searchTerm = "angularjs";
    scope.search();
    httpBackend.flush();

    expect(scope.searchResult.key).toBe("test");
  });

});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter5/recipe5).

### Discussion
Since we now have a clear separation between the service and the controller, we can simply inject the `TwitterAPI` into our `beforeEach` function.

Mocking with the `$httpBackend` is done as a last step in `beforeEach`. When a JSONP request happens we respond with `mockData`. After the `search()` is triggered we `flush()` the `httpBackend` in order to return our `mockData`.

Have a look at the [ngMock.$httpBackend](http://docs.angularjs.org/api/ngMock.$httpBackend) module for more details.