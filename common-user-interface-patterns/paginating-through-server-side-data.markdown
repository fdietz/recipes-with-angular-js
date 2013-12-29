---
layout: recipe
title: Paginating Through Server-Side Data
chapter: common-user-interface-patterns
order: 3
source_path: common-user-interface-patterns/source/recipe3
---

### Problem
You wish to paginate through a large server-side result set.

### Solution
You cannot use the previous method with a filter since that would require all data to be available on the client. Instead we use an implementation with a controller only instead.

The template has not changed much. Only the `ng-repeat` directive looks simpler now:

{% prism markup %}
{% raw %}
<tr ng-repeat="item in pagedItems">
  <td>{{item.id}}</td>
  <td>{{item.name}}</td>
  <td>{{item.description}}</td>
</tr>
{% endraw %}
{% endprism %}

In order to simplify the example we will fake a server-side service by providing an Angular service implementation for the items.

{% prism javascript %}
app.factory("Item", function() {

  var items = [];
  for (var i=0; i<50; i++) {
    items.push({
      id: i, name: "name "+ i, description: "description " + i
    });
  }

  return {
    get: function(offset, limit) {
      return items.slice(offset, offset+limit);
    },
    total: function() {
      return items.length;
    }
  };
});
{% endprism %}

The service manages a list of items and has methods for retrieving a subset of items for a given offset and limit and the total number of items.

The controller uses dependency injection to access the `Item` service and contains almost the same methods as our previous recipe.

{% prism javascript %}
app.controller("PaginationCtrl", function($scope, Item) {

  $scope.itemsPerPage = 5;
  $scope.currentPage = 0;

  $scope.prevPage = function() {
    if ($scope.currentPage > 0) {
      $scope.currentPage--;
    }
  };

  $scope.prevPageDisabled = function() {
    return $scope.currentPage === 0 ? "disabled" : "";
  };

  $scope.nextPage = function() {
    if ($scope.currentPage < $scope.pageCount() - 1) {
      $scope.currentPage++;
    }
  };

  $scope.nextPageDisabled = function() {
    return $scope.currentPage === $scope.pageCount() - 1 ? "disabled" : "";
  };

  $scope.pageCount = function() {
    return Math.ceil($scope.total/$scope.itemsPerPage);
  };

  $scope.$watch("currentPage", function(newValue, oldValue) {
    $scope.pagedItems =
      Item.get(newValue*$scope.itemsPerPage, $scope.itemsPerPage);
    $scope.total = Item.total();
  });

});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter8/recipe3).

### Discussion
When you select the next/previous page you will change the `$scope.currentPage` value and the `$watch` function is triggered. It fetches fresh items for the current page and the total number of items. So, on the client side we only have five items available as defined in `itemsPerPage` and when paginating we throw away the items of the previous page and fetch new items.

If you want to try this with a real backend you only have to swap out the `Item` service implementation.
