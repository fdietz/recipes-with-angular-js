function MyCtrl($scope) {
  $scope.value = 1;

  $scope.incrementValue = function() {
    $scope.value += 1;
  };
}