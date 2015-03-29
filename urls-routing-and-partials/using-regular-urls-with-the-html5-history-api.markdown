---
layout: recipe
title: Using Regular URLs with the HTML5 History API
chapter: urls-routing-and-partials
order: 2
---

### Problem
You want nice looking URLs and can provide server-side support.

### Solution
We will use the same example but use the [Express](http://expressjs.com/) framework to serve all content and handle the URL rewriting.

Let us start with the route configuration:

{% prism javascript %}
app.config(function($routeProvider, $locationProvider) {
  $locationProvider.html5Mode(true);

  $routeProvider.
    when("/persons",
      { templateUrl: "/partials/index.jade",
        controller: "PersonIndexCtrl" }).
    when("/persons/:id",
      { templateUrl: "/partials/show.jade",
        controller: "PersonShowCtrl" }).
    otherwise( { redirectTo: "/persons" });
});
{% endprism %}

There are no changes except for the `html5Mode` method, which enables our new routing mechanism. The Controller implementation does not change at all.

We have to take care of the partial loading though. Our `Express` app will have to serve the partials for us. The initial typical boilerplate for an `Express` app loads the module and creates a server:

{% prism javascript %}
var express = require('express');
var app     = module.exports = express.createServer();
{% endprism %}

We will skip the configuration here and jump directly to the server-side route definition:

{% prism javascript %}
app.get('/partials/:name', function (req, res) {
  var name = req.params.name;
  res.render('partials/' + name);
});
{% endprism %}

The `Express` route definition loads the partial with given name from the `partials` directory and renders its content.

When supporting HTML5 routing, our server has to redirect all other URLs to the entry point of our application, the `index` page. First we define the rendering of the `index` page, which contains the `ng-view` directive:

{% prism javascript %}
app.get('/', function(req, res) {
  res.render('index');
});
{% endprism %}

Then the catch all route which redirects to the same page:

{% prism javascript %}
app.get('*', function(req, res) {
  res.redirect('/');
});
{% endprism %}

Let us quickly check the partials again. Note that they use the [Jade](http://jade-lang.com/) template engine, which relies on indentation to define the HTML document:

{% prism markup %}
{% raw %}
p This is the index partial
ul(ng-repeat="person in persons")
  li
    a(href="/persons/{{person.id}}"){{person.name}}
{% endraw %}
{% endprism %}

The index page creates a list of persons and the show page shows some more details:

{% prism markup %}
{% raw %}
h3 Person Details {{person.name}}
p Age: {{person.age}}
a(href="/persons") Back
{% endraw %}
{% endprism %}

The person details link `/persons/{{person.id}}` and the back link `/persons` are both now much cleaner in my opinion compared to the hashbang URLs.

Have a look at the complete [example on Github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter6/recipe2) and start the `Express` app with `node app.js`.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter6/recipe2).

### Discussion
If we weren't to redirect all requests to the root, what would happen if we were to navigate to the persons list at `http://localhost:3000/persons`? The `Express` framework would show us an error because there is no route defined for `persons`, we only defined routes for our root URL (`/`) and the partials URL `/partials/:name`. The redirect ensures that we actually end up at our root URL, which then kicks in our Angular app. When the client-side routing takes over we then redirect back to the `/persons` URL.

Also note how navigating to a person's detail page will load only the `show.jade` partial and navigating back to the `persons` list won't carry out any server requests. Everything our app needs is loaded once from the server and cached client-side.

If you have a hard time understanding the server implementation, I suggest you read the excellent [Express Guide](http://expressjs.com). Additionally, there is going to be an extra chapter, which goes into more details on how to integrate Angular.js with server-side frameworks.
