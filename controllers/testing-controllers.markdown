---
layout: recipe
title: Testing Controllers
chapter: controllers
order: 7
---

### Problem
You wish to unit test your business logic.

### Solution
Implement a unit test using [Jasmine](http://pivotal.github.com/jasmine/) and the [angular-seed](https://github.com/angular/angular-seed) project. Following our previous `$watch` recipe, this is how our spec would look.

{% prism javascript %}
describe('MyCtrl', function(){
  var scope, ctrl;

  beforeEach(inject(function($controller, $rootScope) {
    scope = $rootScope.$new();
    ctrl = $controller(MyCtrl, { $scope: scope });
  }));

  it('should change greeting value if name value is changed', function() {
    scope.name = "Frederik";
    scope.$digest();
    expect(scope.greeting).toBe("Greetings Frederik");
  });
});
{% endprism %}

### Discussion
Jasmine specs use `describe` and `it` functions to group specs and `beforeEach` and `afterEach` to setup and teardown code. The actual expectation compares the greeting from the scope with our expectation `Greetings Frederik`.

The scope and controller initialization is a bit more involved. We use `inject` to initialize the scope and controller as closely as possible to how our code would behave at runtime too. We can't just initialize the scope as a Javascript object `{}` since we would then not be able to call `$watch` on it. Instead `$rootScope.$new()` will do the trick. Note that the `$controller` service requires `MyCtrl` to be available and uses an object notation to pass in dependencies.

The `$digest` call is required in order to trigger a watch execution after we have changed the scope. We need to call `$digest` manually in our spec whereas at runtime Angular will do this for us automatically.

