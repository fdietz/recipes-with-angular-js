---
layout: recipe
title: Consuming RESTful APIs
chapter: consuming-external-services
order: 2
---

### Problem
You wish to consume a RESTful data source.

### Solution
Use Angular's high-level `$resource` service. Note that the Angular `ngResource` module needs to be separately loaded since it is not included in the base angular.js file:

{% prism markup %}
{% raw %}
<script src="angular-resource.js">
{% endraw %}
{% endprism %}

Let us now start by defining the application module and our `Post` model as an Angular service:

{% prism javascript %}
var app = angular.module('myApp', ['ngResource']);

app.factory("Post", function($resource) {
  return $resource("/api/posts/:id");
});
{% endprism %}

Now we can use our service to retrieve a list of posts inside a controller (example: HTTP GET /api/posts):

{% prism javascript %}
app.controller("PostIndexCtrl", function($scope, Post) {
  Post.query(function(data) {
    $scope.posts = data;
  });
});
{% endprism %}

Or a specific post by `id` (example: HTTP GET /api/posts/1):

{% prism javascript %}
app.controller("PostShowCtrl", function($scope, Post) {
  Post.get({ id: 1 }, function(data) {
    $scope.post = data;
  });
});
{% endprism %}

We can create a new post using save (example: HTTP POST /api/posts):

{% prism javascript %}
Post.save(data);
{% endprism %}

And we can delete a specific post by `id` (example: DELETE /api/posts/1):

{% prism javascript %}
Post.delete({ id: id });
{% endprism %}

The complete example code is based on Brian Ford's [angular-express-seed](https://github.com/btford/angular-express-seed) and uses the [Express](http://expressjs.com/) framework.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter5/recipe2).

### Discussion
Following some conventions simplifies our code quite a bit. We define the `$resource` by passing the URL schema only. This gives us a handful of nice methods including `query`, `get`, `save`, `remove` and `delete` to work with our resource. In the example above we implement several controllers to cover the typical use cases. The `get` and `query` methods expect three arguments, the request parameters, the success and the error callback. The `save` method expects four arguments, the request parameters, the POST data, the success and the error callback.

The `$resource` service currently does not support promises and therefore has a distinctly different interface to the `$http` service. But we don't have to wait very long for it, since work has already started in the 1.1 development branch to introduce promise support for the `$resource` service!

The returned object of a `$resource` query or get function is a `$resource` instance which provides `$save`, `$remove` and `$delete` methods. This allows you to easily fetch a resource and update it as in the following example:

{% prism javascript %}
var post = Post.get({ id: 1 }, function() {
  post.title = "My new title";
  post.$save();
});
{% endprism %}

It is important to notice that the `get` call immediately returns an empty reference - in our case the `post` variable. Once the data is returned from the server the existing reference is populated and we can change our post title and use the `$save` method conveniently.

Note that having an empty reference means that our post will not be rendered in the template. Once the data is returned though, the view automatically re-renders itself showing the new data.

#### Configuration

What if your response of posts is not an array but a more complex json? This typically results in the following error:

    TypeError: Object #<Resource> has no method 'push'

Angular seems to expect your service to return a JSON array. Have a look at the following JSON example, which wraps a `posts` array in a JSON object:

    {
      "posts": [
        {
          "id"    : 1,
          "title" : "title 1"
        },
        {
          "id": 2,
          "title" : "title 2"
        }
      ]
    }

In this case you have to change the `$resource` definition accordingly.

{% prism javascript %}
app.factory("Post", function($resource) {
  return $resource("/api/posts/:id", {}, {
    query: { method: "GET", isArray: false }
  });
});

app.controller("PostIndexCtrl", function($scope, Post) {
  Post.query(function(data) {
    $scope.posts = data.posts;
  });
});
{% endprism %}

We only change the configuration of the `query` action to not expect an array by setting the `isArray` attribute to `false`. Then in our controller we can directly access `data.posts`.

It is generally good practice to encapsulate your model and `$resource` usage in an Angular service module and inject that in your controller. This way you can easily reuse the same model in different controllers and test it more easily.
