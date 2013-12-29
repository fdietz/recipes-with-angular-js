---
layout: recipe
title: Displaying a Modal Dialog
chapter: common-user-interface-patterns
order: 7
source_path: common-user-interface-patterns/source/recipe7
---

### Question
You wish to use a Modal Dialog using the Twitter Bootstrap Framework. A dialog is called modal when it is blocking the rest of your web application until it is closed.

### Solution
Use the `angular-ui` module's nice `modal` plugin, which directly supports Twitter Bootstrap.

The template defines a button to open the modal and the modal code itself.

{% prism markup %}
{% raw %}
<body ng-app="MyApp" ng-controller="MyCtrl">

  <button class="btn" ng-click="open()">Open Modal</button>

  <div modal="showModal" close="cancel()">
    <div class="modal-header">
        <h4>Modal Dialog</h4>
    </div>
    <div class="modal-body">
        <p>Example paragraph with some text.</p>
    </div>
    <div class="modal-footer">
      <button class="btn btn-success" ng-click="ok()">Okay</button>
      <button class="btn" ng-click="cancel()">Cancel</button>
    </div>
  </div>

</body>
{% endraw %}
{% endprism %}

Note that even though we don't specify it explicitly the modal dialog is hidden initially via the `modal` attribute. The controller only handles the button click and the `showModal` value used by the `modal` attribute.

{% prism javascript %}
var app = angular.module("MyApp", ["ui.bootstrap.modal"]);

$scope.open = function() {
  $scope.showModal = true;
};

$scope.ok = function() {
  $scope.showModal = false;
};

$scope.cancel = function() {
  $scope.showModal = false;
};
{% endprism %}

Do not forget to download and include the angular-ui.js file in a script tag. The module dependency is defined directly to "ui.bootstrap.modal". The [full example](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter8/recipe7) is available on Github including the angular-ui module.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter8/recipe7).

### Discussion
The modal as defined in the template is straight from the Twitter bootstrap [documentation](http://twitter.github.com/bootstrap/javascript.html#modals). We can control the visibility with the `modal` attribute. Additionally, the `close` attribute defines a `close` function which is called whenever the dialog is closed. Note that this could happen if the user presses the `escape` key or clicking outside the modal.

Our own cancel button uses the same function to close the modal manually, whereas the okay button uses the `ok` function. This makes it easy for us to distinguish between a user who simply cancelled the modal or actually pressed the okay button.
