---
layout: recipe
title: Paginating Using Infinite Results
chapter: common-user-interface-patterns
order: 4
source_path: common-user-interface-patterns/source/recipe4
---

### Problem
You wish to paginate through server-side data with a "Load More" button, which just keeps appending more data until no more data is available.

### Solution
Let's start by looking at how the item table is rendered with the `ng-repeat` Directive.

{% prism markup %}
{% raw %}
<div ng-controller="PaginationCtrl">
  <table class="table table-striped">
    <thead>
      <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Description</th>
      </tr>
    </thead>
    <tbody>
      <tr ng-repeat="item in pagedItems">
        <td>{{item.id}}</td>
        <td>{{item.name}}</td>
        <td>{{item.description}}</td>
      </tr>
    </tbody>
    <tfoot>
      <td colspan="3">
        <button class="btn" href="#" ng-class="nextPageDisabledClass()"
          ng-click="loadMore()">Load More</button>
      </td>
    </tfoot>
  </table>
</div>
{% endraw %}
{% endprism %}

The controller uses the same `Item` Service as used for the previous recipe and handles the logic for the "Load More" button.

{% prism javascript %}
app.controller("PaginationCtrl", function($scope, Item) {

  $scope.itemsPerPage = 5;
  $scope.currentPage = 0;
  $scope.total = Item.total();
  $scope.pagedItems = Item.get($scope.currentPage*$scope.itemsPerPage,
    $scope.itemsPerPage);

  $scope.loadMore = function() {
    $scope.currentPage++;
    var newItems = Item.get($scope.currentPage*$scope.itemsPerPage,
      $scope.itemsPerPage);
    $scope.pagedItems = $scope.pagedItems.concat(newItems);
  };

  $scope.nextPageDisabledClass = function() {
    return $scope.currentPage === $scope.pageCount()-1 ? "disabled" : "";
  };

  $scope.pageCount = function() {
    return Math.ceil($scope.total/$scope.itemsPerPage);
  };

});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter8/recipe4).

### Discussion
The solution is actually pretty similar to the previous recipe and uses a controller only again. The `$scope.pagedItems` is retrieved initially to render the first five items.

When pressing the "Load More" button we fetch another set of items incrementing the `currentPage` to change the `offset` of the `Item.get` function. The new items will be concatenated with the existing items using the Array `concat` function. The changes to `pagedItems` will be automatically rendered by the `ng-repeat` directive.

The `nextPageDisabledClass` checks whether there is more data available by calculating the total number of pages in `pageCount` and comparing that to the current page.
