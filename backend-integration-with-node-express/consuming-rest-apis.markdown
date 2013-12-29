---
layout: recipe
title: Consuming REST APIs
chapter: backend-integration-with-node-express
order: 1
source_path: backend-integration-with-node-express/source/recipe1
---

### Problem
You wish to consume a JSON REST API implemented in your Express application.

### Solution
Using the `$resource` service we will begin by defining our Contact model and all RESTful actions.

{% prism javascript %}
app.factory("Contact", function($resource) {
  return $resource("/api/contacts/:id", { id: "@_id" },
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

We can now fetch a list of contacts using `Contact.index()` and a single contact with `Contact.show(id)`. These actions can be directly mapped to the API routes defined in `app.js`.

{% prism javascript %}
var express = require('express'),
        api = require('./routes/api');

var app = module.exports = express();

app.get('/api/contacts', api.contacts);
app.get('/api/contacts/:id', api.contact);
app.post('/api/contacts', api.createContact);
app.put('/api/contacts/:id', api.updateContact);
app.delete('/api/contacts/:id', api.destroyContact);
{% endprism %}

I like to keep routes in a separate file `routes/api.js` and just reference them in `app.js` in order to keep it small. The API implementation first initializes the [Mongoose](http://mongoosejs.com/) library and defines a schema for our Contact model.

{% prism javascript %}
var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/contacts_database');

var contactSchema = mongoose.Schema({
  firstname: 'string', lastname: 'string', age: 'number'
});
var Contact = mongoose.model('Contact', contactSchema);
{% endprism %}

We can now use the `Contact` model to implement the API. Lets start with the index action:

{% prism javascript %}
exports.contacts = function(req, res) {
  Contact.find({}, function(err, obj) {
    res.json(obj)
  });
};
{% endprism %}

Skipping the error handling we retrieve all contacts with the `find` function provided by Mongoose and render the result in the JSON format. The show action is pretty similar except it uses `findOne` and the id from the URL parameter to retrieve a single contact.

{% prism javascript %}
exports.contact = function(req, res) {
  Contact.findOne({ _id: req.params.id }, function(err, obj) {
    res.json(obj);
  });
};
{% endprism %}

As a final example we will create a new Contact instance passing in the request body and call the `save` method to persist it:

{% prism javascript %}
exports.createContact = function(req, res) {
  var contact = new Contact(req.body);
  contact.save();
  res.json(req.body);
};
{% endprism %}

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter10/recipe1).

### Discussion
Let have a look again at the example for the contact function, which retrieves a single Contact. It uses `_id` instead of `id` as the parameter for the `findOne` function. This underscore is intentional and used by MongoDB for its auto-generated IDs. In order to automatically map from `id` to the `_id` parameter we used a nice trick of the `$resource` service. Take a look at the second parameter of the Contact `$resource` definition: `{ id: "@_id" }`. Using this parameter Angular will automatically set the URL parameter `id` based on the value of the model attribute `_id`.
