---
layout: recipe
title: Consuming REST APIs
chapter: backend-integration-with-ruby-on-rails
order: 1
---

### Problem
You wish to consume a JSON REST API implemented in your Rails application.

### Solution
Using the `$resource` service is a great start and can be tweaked to feel more natural to a Rails developer by configuring the methods in accordance with the Rails actions.

{% prism javascript %}
app.factory("Contact", function($resource) {
  return $resource("/api/contacts/:id", { id: "@id" },
    {
      'create':  { method: 'POST' },
      'index':   { method: 'GET', isArray: true },
      'show':    { method: 'GET', isArray: false },
      'update':  { method: 'PUT' },
      'destroy': { method: 'DELETE' }
    }
  );
});
{% endprism %}

We can now fetch a list of contacts using `Contact.index()` and a single contact with `Contact.show(id)`. These actions can be directly mapped to the `ContactsController` actions in your Rails backend.

{% prism ruby %}
class ContactsController < ApplicationController
  respond_to :json

  def index
    @contacts = Contact.all
    respond_with @contacts
  end

  def show
    @contact = Contact.find(params[:id])
    respond_with @contact
  end

  ...
end
{% endprism %}

The Rails action controller uses a `Contact` ActiveRecord model with the usual contact attributes like firstname, lastname, age, etc. By specifying `respond_to :json` the controller only responds to the JSON resource format and we can use `respond_with` to automatically transform the `Contact` model to a JSON response.

The route definition uses the Rails default resource routing and an `api` scope to separate the API requests from other requests.

{% prism ruby %}
Contacts::Application.routes.draw do
  scope "api" do
    resources :contacts
  end
end
{% endprism %}

This will generate paths like for example `api/contacts` and `api/contacts/:id` for the HTTP GET method.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter9/recipe1).

### Discussion
If you want to get up to speed with Ruby on Rails, I suggest that you look into the [Rails Guides](http://guides.rubyonrails.org/index.html) which will help you understand how all the pieces fit together.

#### Rails Security using Authenticity Token
The example code above works nicely until we use the HTTP methods `POST`, `PUT` and `DELETE` with the resource. As a security mechanism, Rails expects an authenticity token to prevent a CSRF ([Cross Site Request Forgery](http://guides.rubyonrails.org/security.html#cross-site-request-forgery-csrf)) attack. We need  to submit an additional HTTP header `X-CSRF-Token` with the token. It is conveniently rendered in the HTML `meta` tag `csrf-token` by Rails. Using jQuery we can fetch that meta tag definition and configure the `$httpProvider` appropriately.

{% prism javascript %}
var app = angular.module("Contacts", ["ngResource"]);
app.config(function($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] =
    $('meta[name=csrf-token]').attr('content');
});
{% endprism %}

#### Rails JSON response format
If you are using a Rails version prior 3.1, you'll notice that the JSON response will use a `contact` namespace for the model attributes which breaks your Angular.js code. To disable this behavior you can configure your Rails app accordingly.

{% prism ruby %}
ActiveRecord::Base.include_root_in_json = false
{% endprism %}

There are still inconsistencies between the Ruby and Javascript world. For example, in Ruby we use underscored attribute names (display_name) whereas in Javascript we use camelCase (displayName).

There is a custom `$resource` implementation [angularjs-rails-resource](https://github.com/tpodom/angularjs-rails-resource) available to streamline consuming Rails resources. It uses transformers and inceptors to rename the attribute fields and handles the root wrapping behavior for you.
