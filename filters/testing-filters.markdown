---
layout: recipe
title: Testing Filters
chapter: filters
order: 6
source_path: filters/source/recipe6
---

### Problem
You wish to unit test your new filter. Let us start with an easy filter, which renders a checkmark depending on a boolean value.

{% prism markup %}
{% raw %}
<body ng-init="data = true">
  <p>{{ data | checkmark}}</p>
  <p>{{ !data | checkmark}}</p>
</body>
{% endraw %}
{% endprism %}

{% prism javascript %}
var app = angular.module("MyApp", []);

app.filter('checkmark', function() {
  return function(input) {
    return input ? '\u2713' : '\u2718';
  };
});
{% endprism %}

### Solution
Use the angular-seed project as a bootstrap again.

{% prism javascript %}
describe('MyApp Tabs', function() {
  beforeEach(module('MyApp'));

  describe('checkmark', function() {
     it('should convert boolean values to unicode checkmark or cross',
        inject(function(checkmarkFilter) {
       expect(checkmarkFilter(true)).toBe('\u2713');
       expect(checkmarkFilter(false)).toBe('\u2718');
     }));
   });
});
{% endprism %}

### Discussion
The `beforeEach` loads the module and the `it` method injects the filter function for us. Note, that it has to be called `checkmarkFilter`, otherwise Angular can't inject our filter function correctly.