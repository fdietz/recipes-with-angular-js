---
layout: recipe
title: Testing Directives
chapter: directives
order: 8
---

### Problem
You wish to test your directive with a unit test. As an example we will use a tab component directive implementation, which can easily be used in your HTML document.

{% prism markup %}
<tabs>
  <pane title="First Tab">First pane.</pane>
  <pane title="Second Tab">Second pane.</pane>
</tabs>
{% endprism %}

The directive implementation is split into the tabs and the pane directive. Let us start with the tabs
directive.

{% prism javascript %}
app.directive("tabs", function() {
  return {
    restrict: "E",
    transclude: true,
    scope: {},
    controller: function($scope, $element) {
      var panes = $scope.panes = [];

      $scope.select = function(pane) {
        angular.forEach(panes, function(pane) {
          pane.selected = false;
        });
        pane.selected = true;
        console.log("selected pane: ", pane.title);
      };

      this.addPane = function(pane) {
        if (!panes.length) $scope.select(pane);
        panes.push(pane);
      };
    },
    template:
      '<div class="tabbable">' +
        '<ul class="nav nav-tabs">' +
          '<li ng-repeat="pane in panes"' +
              'ng-class="{active:pane.selected}">'+
            '<a href="" ng-click="select(pane)">{{pane.title}}</a>' +
          '</li>' +
        '</ul>' +
        '<div class="tab-content" ng-transclude></div>' +
      '</div>',
    replace: true
  };
});
{% endprism %}

It manages a list of `panes` and the selected state of the `panes`. The template definition makes use of the selection to change the class and responds on the click event to change the selection.

The `pane` directive depends on the `tabs` directive to add itself to it.

{% prism javascript %}
app.directive("pane", function() {
  return {
    require: "^tabs",
    restrict: "E",
    transclude: true,
    scope: {
      title: "@"
    },
    link: function(scope, element, attrs, tabsCtrl) {
      tabsCtrl.addPane(scope);
    },
    template:
      '<div class="tab-pane" ng-class="{active: selected}"' +
        'ng-transclude></div>',
    replace: true
  };
});
{% endprism %}

### Solution
Using the angular-seed in combination with jasmine and jasmine-jquery, you can implement a unit test.

{% prism javascript %}
describe('MyApp Tabs', function() {
  var elm, scope;

  beforeEach(module('MyApp'));

  beforeEach(inject(function($rootScope, $compile) {
    elm = angular.element(
      '<div>' +
        '<tabs>' +
          '<pane title="First Tab">' +
            'First content is {{first}}' +
          '</pane>' +
          '<pane title="Second Tab">' +
            'Second content is {{second}}' +
          '</pane>' +
        '</tabs>' +
      '</div>');

    scope = $rootScope;
    $compile(elm)(scope);
    scope.$digest();
  }));

  it('should create clickable titles', function() {
    console.log(elm.find('ul.nav-tabs'));
    var titles = elm.find('ul.nav-tabs li a');

    expect(titles.length).toBe(2);
    expect(titles.eq(0).text()).toBe('First Tab');
    expect(titles.eq(1).text()).toBe('Second Tab');
  });

  it('should set active class on title', function() {
    var titles = elm.find('ul.nav-tabs li');

    expect(titles.eq(0)).toHaveClass('active');
    expect(titles.eq(1)).not.toHaveClass('active');
  });

  it('should change active pane when title clicked', function() {
    var titles = elm.find('ul.nav-tabs li');
    var contents = elm.find('div.tab-content div.tab-pane');

    titles.eq(1).find('a').click();

    expect(titles.eq(0)).not.toHaveClass('active');
    expect(titles.eq(1)).toHaveClass('active');

    expect(contents.eq(0)).not.toHaveClass('active');
    expect(contents.eq(1)).toHaveClass('active');
  });
});
{% endprism %}

### Discussion
Combining jasmine with jasmine-jquery gives you useful assertions like `toHaveClass` and actions like `click`, which are used extensively in the example above.

To prepare the template we use `$compile` and `$digest` in the `beforeEach` function and then access the resulting Angular element in our tests.

The angular-seed project was slightly extended to add jquery and jasmine-jquery to the project.

The example code was extracted from [Vojta Jina' Github example](https://github.com/vojtajina/ng-directive-testing/tree/start) - the author of the awesome [Testacular](https://github.com/testacular/testacular).
