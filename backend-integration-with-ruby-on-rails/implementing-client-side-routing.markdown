---
layout: recipe
title: Implementing Client-Side Routing
chapter: backend-integration-with-ruby-on-rails
order: 2
---

### Problem
You wish to use client-side routing in conjunction with a Ruby on Rails backend.

### Solution
Every request to the backend should initially render the complete page in order to load our Angular app. Only then will the client-side rendering take over. Let us first have a look at the route definition for this "catch all" route.

{% prism ruby %}
Contacts::Application.routes.draw do
  root :to => "layouts#index"
  match "*path" => "layouts#index"
end
{% endprism %}

It uses [Route Globbing](http://guides.rubyonrails.org/routing.html#route-globbing) to match all URLs and defines a root URL. Both will be handled by a layout controller with the sole purpose of rendering the initial layout.

{% prism ruby %}
class LayoutsController < ApplicationController
  def index
    render "layouts/application"
  end
end
{% endprism %}

The actual layout template defines our `ng-view` directive and resides in `app/views/layouts/application.html` - nothing new here. So let's skip ahead to the Angular route definition in `app.js.erb`.

{% prism javascript %}
var app = angular.module("Contacts", ["ngResource"]);

app.config(function($routeProvider, $locationProvider) {
  $locationProvider.html5Mode(true);
  $routeProvider
    .when("/contacts",
      { templateUrl: "<%= asset_path('contacts/index.html') %> ",
        controller: "ContactsIndexCtrl" })
    .when("/contacts/new",
      { templateUrl: "<%= asset_path('contacts/edit.html') %> ",
        controller: "ContactsEditCtrl" })
    .when("/contacts/:id",
      { templateUrl: "<%= asset_path('contacts/show.html') %> ",
        controller: "ContactsShowCtrl" })
    .when("/contacts/:id/edit",
      { templateUrl: "<%= asset_path('contacts/edit.html') %> ",
        controller: "ContactsEditCtrl" })
    .otherwise({ redirectTo: "/contacts" });
});
{% endprism %}

We set the `$locationProvider` to use the HTML5 mode and define our client-side routes for listing, showing, editing and creating new contacts.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter9/recipe1).

### Discussion
Let us have a look into the route definition again. First of all the filename ends with `erb`, since it uses ERB tags in the javascript file, courtesy of the [Rails Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html). The  `asset_path` method is used to retrieve the URL to the HTML partials since it will change depending on the environment. On production the filename contains an MD5 checksum and the actual ERB output will change from `/assets/contacts/index.html` to `/assets/contacts/index-7ce113b9081a20d93a4a86e1aacce05f.html`. If your Rails app is configured to use an asset host, the path will in fact be absolute.
