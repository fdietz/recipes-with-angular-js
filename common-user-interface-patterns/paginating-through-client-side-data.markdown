---
layout: recipe
title: Paginating Through Client-Side Data
chapter: common-user-interface-patterns
order: 2
source_path: common-user-interface-patterns/source/recipe2
---

### Problem
You have a table of data completely client-side and want to paginate through the data.

### Solution
Use an HTML table element with the `ng-repeat` directive to render only the items for the current page. All the pagination logic should be handled in a custom filter and controller implementation.

Let us start with the template using Twitter Bootstrap for the table and pagination elements:

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
      <tr ng-repeat="item in items |
        offset: currentPage*itemsPerPage |
        limitTo: itemsPerPage">
        <td>{{item.id}}</td>
        <td>{{item.name}}</td>
        <td>{{item.description}}</td>
      </tr>
    </tbody>
    <tfoot>
      <td colspan="3">
        <div class="pagination">
          <ul>
            <li ng-class="prevPageDisabled()">
              <a href ng-click="prevPage()">« Prev</a>
            </li>
            <li ng-repeat="n in range()"
              ng-class="{active: n == currentPage}" ng-click="setPage(n)">
              <a href="#">{{n+1}}</a>
            </li>
            <li ng-class="nextPageDisabled()">
              <a href ng-click="nextPage()">Next »</a>
            </li>
          </ul>
        </div>
      </td>
    </tfoot>
  </table>
</div>
{% endraw %}
{% endprism %}

The `offset` Filter is responsible for selecting the subset of items for the current page. It uses the `slice` function on the Array given the start param as the index.

{% prism javascript %}
app.filter('offset', function() {
  return function(input, start) {
    start = parseInt(start, 10);
    return input.slice(start);
  };
});
{% endprism %}

The controller manages the actual `$scope.items` array and handles the logic for enabling/disabling the pagination buttons.

{% prism javascript %}
app.controller("PaginationCtrl", function($scope) {

  $scope.itemsPerPage = 5;
  $scope.currentPage = 0;
  $scope.items = [];

  for (var i=0; i<50; i++) {
    $scope.items.push({
      id: i, name: "name "+ i, description: "description " + i
    });
  }

  $scope.prevPage = function() {
    if ($scope.currentPage > 0) {
      $scope.currentPage--;
    }
  };

  $scope.prevPageDisabled = function() {
    return $scope.currentPage === 0 ? "disabled" : "";
  };

  $scope.pageCount = function() {
    return Math.ceil($scope.items.length/$scope.itemsPerPage)-1;
  };

  $scope.nextPage = function() {
    if ($scope.currentPage < $scope.pageCount()) {
      $scope.currentPage++;
    }
  };

  $scope.nextPageDisabled = function() {
    return $scope.currentPage === $scope.pageCount() ? "disabled" : "";
  };

});
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter8/recipe2).

### Discussion
The initial idea of this pagination solution can be best explained by looking into the usage of `ng-repeat` to render the table rows for each item:

{% prism markup %}
{% raw %}
<tr ng-repeat="item in items |
  offset: currentPage*itemsPerPage |
  limitTo: itemsPerPage">
  <td>{{item.id}}</td>
  <td>{{item.name}}</td>
  <td>{{item.description}}</td>
</tr>
{% endraw %}
{% endprism %}

The `offset` filter uses the `currentPage*itemsPerPage` to calculate the offset for the array slice operation. This will generate an array from the offset to the end of the array. Then we use the built-in `limitTo` filter to subset the array to the number of `itemsPerPage`. All this is done on the client side with filters only.

The controller is responsible for supporting a `nextPage` and `prevPage` action and the accompanying functions to check the disabled state of these actions via `ng-class` directive: `nextPageDisabled` and `prevPageDisabled`. The `prevPage` function first checks if it has not reached the first page yet before decrementing the `currentPage` and the `nextPage` does the same for the last page and the same logic is applied for the disabled checks.

This example is already quite involved and I intentionally omitted an explanation of the rendering of links between the previous and next buttons. The [full implementation](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter8/recipe2) is online though for you to investigate.
