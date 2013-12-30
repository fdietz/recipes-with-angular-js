---
layout: recipe
title: Deferred and Promise
chapter: consuming-external-services
order: 4
---

### Problem
You wish to synchronize multiple asynchronous functions and avoid Javascript callback hell.

### Solution
As an example, we want to call three services in sequence and combine the result of them. Let us start with a nested approach:

{% prism javascript %}
tmp = [];

$http.get("/app/data/first.json").success(function(data) {
  tmp.push(data);
  $http.get("/app/data/second.json").success(function(data) {
    tmp.push(data);
    $http.get("/app/data/third.json").success(function(data) {
      tmp.push(data);
      $scope.combinedNestedResult = tmp.join(", ");
    });
  });
});
{% endprism %}

We call the `get` function three times to retrieve three JSON documents each with an array of strings. We haven't even started adding error handling but already using nested callbacks the code becomes messy and can be simplified using the `$q` service:

{% prism javascript %}
var first  = $http.get("/app/data/first.json"),
    second = $http.get("/app/data/second.json"),
    third  = $http.get("/app/data/third.json");

$q.all([first, second, third]).then(function(result) {
  var tmp = [];
  angular.forEach(result, function(response) {
    tmp.push(response.data);
  });
  return tmp;
}).then(function(tmpResult) {
  $scope.combinedResult = tmpResult.join(", ");
});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter5/recipe4).

### Discussion
The `all` function combines multiple promises into a single promise and solves our problem quite elegantly.

Let's have a closer look at the `then` method. It is rather contrived but should give you an idea of how to use `then` to sequentially call functions and pass data along. Since the `all` function returns a promise again we can call `then` on it. By returning the `tmp` variable it will be passed along to the then function as `tmpResult` argument.

Before finishing this recipe let us quickly discuss an example where we have to create our own deferred object:

{% prism javascript %}
function deferredTimer(success) {
  var deferred = $q.defer();

  $timeout(function() {
    if (success) {
      deferred.resolve({ message: "This is great!" });
    } else {
      deferred.reject({ message: "Really bad" });
    }
  }, 1000);

  return deferred.promise;
}
{% endprism %}

Using the `defer` method we create a deferred instance. As an example of an asynchronous operation we will use the `$timeout` service which will either resolve or reject our operation depending on the boolean success parameter. The function will immediately return the `promise` and therefore not render any result in our HTML template. After one second, the timer will execute and return our success or failure response.

This `deferredTimer` can be triggered in our HTML template by wrapping it into a function defined on the scope:

{% prism javascript %}
$scope.startDeferredTimer = function(success) {
  deferredTimer(success).then(
    function(data) {
      $scope.deferredTimerResult = "Successfully finished: " +
        data.message;
    },
    function(data) {
      $scope.deferredTimerResult = "Failed: " + data.message;
    }
  );
};
{% endprism %}

Our `startDeferredTimer` function will get a `success` parameter which it passes along to the `deferredTimer`. The `then` function expects a success and an error callback as arguments which we use to set a scope variable `deferredTimerResult` to show our result.

This is just one of many examples of how promises can simplify your code, but you can find many more examples by looking into [Kris Kowal's Q implementation](https://github.com/kriskowal/q).
