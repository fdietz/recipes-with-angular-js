---
layout: recipe
title: Validating Forms Server-Side
chapter: backend-integration-with-ruby-on-rails
order: 3
source_path: backend-integration-with-ruby-on-rails/source/recipe3
---

### Problem
You wish to validate forms using a server-side REST API provided by Rails.

### Solution
Rails already provides model validation support out of the box for us. Let us start with the Contact [ActiveRecord model](http://guides.rubyonrails.org/active_record_validations_callbacks.html).

{% prism ruby %}
class Contact < ActiveRecord::Base
  attr_accessible :age, :firstname, :lastname

  validates :age, :numericality => {
    :only_integer => true, :less_than_or_equal_to => 50 }
end
{% endprism %}

It defines a validation on the `age` attribute. It must be an integer and less or equal to 50 years.

In the `ContactsController` we can use that to make sure the REST API returns proper error messages. As an example let us look into the `create` action.

{% prism ruby %}
class ContactsController < ApplicationController
  respond_to :json

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

end
{% endprism %}

On success it will render the contact model using a JSON presentation and on failure it will return all validation errors transformed to JSON. Let us have a look at an example JSON response:

{% prism javascript %}
{ "age": ["must be less than or equal to 50"] }
{% endprism %}

It is a hash with an entry for each attribute with validation errors. The value is an array of Strings since there might be multiple errors at the same time.

Let us move on to the client-side of our application. The Angular.js contact `$resource` calls the create function and passes the failure callback function.

{% prism javascript %}
Contact.create($scope.contact, success, failure);

function failure(response) {
  _.each(response.data, function(errors, key) {
    _.each(errors, function(e) {
      $scope.form[key].$dirty = true;
      $scope.form[key].$setValidity(e, false);
    });
  });
}
{% endprism %}

Note that ActiveRecord attributes can have multiple validations defined. That is why the `failure` function iterates through each validation entry and each error and uses `$setValidity` and `$dirty` to mark the form fields as invalid.

Now we are ready to show some feedback to our users using the same approach discussed already in the forms chapter.

{% prism markup %}
{% raw %}
<div class="control-group" ng-class="errorClass('age')">
  <label class="control-label" for="age">Age</label>
  <div class="controls">
    <input ng-model="contact.age" type="text" name="age"
      placeholder="Age" required>
    <span class="help-block"
      ng-show="form.age.$invalid && form.age.$dirty">
      {{errorMessage('age')}}
    </span>
  </div>
</div>
{% endraw %}
{% endprism %}

The `errorClass` function adds the `error` CSS class if the form field is invalid and dirty. This will render the label, input field and the help block with a red color.

{% prism javascript %}
$scope.errorClass = function(name) {
  var s = $scope.form[name];
  return s.$invalid && s.$dirty ? "error" : "";
};
{% endprism %}

The `errorMessage` will print a more detailed error message and is defined in the same controller.

{% prism javascript %}
$scope.errorMessage = function(name) {
  result = [];
  _.each($scope.form[name].$error, function(key, value) {
    result.push(value);
  });
  return result.join(", ");
};
{% endprism %}

It iterates over each error message and creates a comma separated String out of it.

You can find the complete example on [github](https://github.com/fdietz/recipes-with-angular-js-examples/tree/master/chapter9/recipe1).

### Discussion
Finally, the `errorMessage` handling is of course pretty primitive. A user would expect a localized failure message instead of this technical presentation. The Rails [Internationalization Guide](http://guides.rubyonrails.org/i18n.html#translations-for-active-record-models) describes how to translate validation error messages in Rails and might prove helpful to further use that in your client-side code.