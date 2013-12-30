---
layout: recipe
title: Implementing Client-Side Routing
chapter: backend-integration-with-node-express
order: 2
---

### Problem
You wish to use client-side routing in conjunction with an Express backend.

### Solution
Every request to the backend should initially render the complete layout in order to load our Angular app. Only then will the client-side rendering take over. Let us first have a look at the route definition for this "catch all" route in our `app.js`.

{% prism javascript %}
var express = require('express'),
     routes = require('./routes');

app.get('/', routes.index);
app.get('*', routes.index);
{% endprism %}

It uses the wildcard character to catch all requests in order to get processed with the `routes.index` module. Additionally, it defines the route to use the same module. The module again resides in `routes/index.js`.

{% prism javascript %}
exports.index = function(req, res){
  res.render('layout');
};
{% endprism %}

The implementation only renders the layout template. It uses the [Jade](http://jade-lang.com/) template engine.

{% prism markup %}
{% raw %}
!!!
html(ng-app="myApp")
  head
    meta(charset='utf8')
    title Angular Express Seed App
    link(rel='stylesheet', href='/css/bootstrap.css')
  body
    div
      ng-view

    script(src='js/lib/angular/angular.js')
    script(src='js/lib/angular/angular-resource.js')
    script(src='js/app.js')
    script(src='js/services.js')
    script(src='js/controllers.js')
{% endraw %}
{% endprism %}

Now that we can actually render the initial layout we can get started with the client-side routing definition in `app.js`

{% prism javascript %}
var app = angular.module('myApp', ["ngResource"]).
  config(['$routeProvider', '$locationProvider',
    function($routeProvider, $locationProvider) {
      $locationProvider.html5Mode(true);
      $routeProvider
        .when("/contacts", {
          templateUrl: "partials/index.jade",
          controller: "ContactsIndexCtrl" })
        .when("/contacts/new", {
          templateUrl: "partials/edit.jade",
          controller: "ContactsEditCtrl" })
        .when("/contacts/:id", {
          templateUrl: "partials/show.jade",
          controller: "ContactsShowCtrl" })
        .when("/contacts/:id/edit", {
          templateUrl: "partials/edit.jade",
          controller: "ContactsEditCtrl" })
        .otherwise({ redirectTo: "/contacts" });
    }
  ]
);
{% endprism %}

We define route definitions to list, show and edit contacts and use a set of partials and corresponding controllers. In order for the partials to get loaded correctly we need to add another express route in the backend which serves all these partials.

{% prism javascript %}
app.get('/partials/:name', function (req, res) {
  var name = req.params.name;
  res.render('partials/' + name);
});
{% endprism %}

It uses the name of the partial as an URL param and renders the partial with the given name from the `partial` directory. Keep in mind that you must define that route before the catch all route, otherwise it will not work.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter10/recipe1).

### Discussion
Compared to Rails the handling of partials is quite explicit by defining a route for partials. On the other hand it is quite nice to being able to use jade templates for our partials too.
