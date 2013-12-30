---
layout: recipe
title: Client-Side Routing with Hashbang URLs
chapter: urls-routing-and-partials
order: 1
---

### Problem
You wish the browser address bar to reflect your applications page flow consistently.

### Solution
Use the `$routeProvider` and `$locationProvider` services to define your routes and the `ng-view` directive as the placeholder for the partials, which should be shown for a particular route definition.

The main template uses the `ng-view` directive:

{% prism markup %}
{% raw %}
<body>
  <h1>Routing Example</h1>
  <ng-view></ng-view>
</body>
{% endraw %}
{% endprism %}

The route configuration is implemented in `app.js` using the `config` method:

{% prism javascript %}
var app = angular.module("MyApp", []).
  config(function($routeProvider, $locationProvider) {
    $locationProvider.hashPrefix('!');
    $routeProvider.
      when("/persons", { templateUrl: "partials/person_list.html" }).
      when("/persons/:id",
        { templateUrl: "partials/person_details.html",
          controller: "ShowCtrl" }).
      otherwise( { redirectTo: "/persons" });
});
{% endprism %}

It is set up to render either the `person_list.html` or the `person_details.html` partial depending on the URL. The partial `person_list.html` renders a list of `persons`:

{% prism markup %}
{% raw %}
<h3>Person List</h3>
<div ng-controller="IndexCtrl">
  <table>
    <thead>
      <tr>
        <td>Name</td>
        <td>Actions</td>
      </tr>
    </thead>
    <tbody>
      <tr ng-repeat="person in persons">
        <td>{{person.name}}</td>
        <td><a href="#!persons/{{person.id}}">Details</a></td>
      </tr>
    </tbody>
  </table>
</div>
{% endraw %}
{% endprism %}

And the partial `person_details.html` shows more detailed information for a specific `person`:

{% prism markup %}
{% raw %}
<h3>{{person.name}} Details</h3>
<p>Name: {{person.name}}</p>
<p>Age: {{person.age}}</p>

<a href="#!persons">Go back</a>
{% endraw %}
{% endprism %}

This example is based on the Angular Seed Bootstrap again and will not work without starting the development server.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter6/recipe1).

### Discussion
Let's give our app a try and open the `index.html`. The `otherwise` defined route redirects us from `index.html` to `index.html#!/persons`. This is the default behavior in case other `when` conditions don't apply.

Take a closer look at the `index.html#!/persons` URL and note how the hashbang (#!) separates the `index.html` from the dynamic client-side part `/persons`. By default, Angular would use the hash (#) character but we configured it to use the hashbang instead, following Google's [Making AJAX applications crawlable](https://developers.google.com/webmasters/ajax-crawling/) guide.

The `/persons` route loads the `person_list.html` partial via HTTP Request (that is also the reason why it won't work without a development server). It shows a list of persons and therefore defines a `ng-controller` directive inside the template. Let us assume for now that the controller implementation defines a `$scope.persons` somewhere. Now for each person we also render a link to show the details via `#!persons/{{person.id}}`.

The route definition for the person's details uses a placeholder `/persons/:id` which resolves to a specific person's details, for example `/persons/1`. The `person_details.html` partial and additionally a controller are defined for this URL. The controller will be scoped to the partial, which basically resembles our `index.html` template where we defined our own `ng-controller` directive to achieve the same effect.

The `person_details.html` has a back link to `#!persons` which leads back to the `person_list.html` page.

Let us come back to the `ng-view` directive. It is automatically bound to the router definition. Therefore you can currently use only a single `ng-view` on your page. For example, you cannot use nested `ng-view`s to achieve user interaction patterns with a first and second level navigation.

And finally the HTTP request for the partials happens only once and is then cached via `$templateCache` service.

Finally, the hashbang-based routing is client-side only and doesn't require server-side configuration. Let us look into the HTML5-based approach next.
