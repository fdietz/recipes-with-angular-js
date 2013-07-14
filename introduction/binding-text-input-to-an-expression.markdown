---
layout: recipe
title: Binding a Text Input to an Expression
chapter: introduction
order: 2
source_path: introduction/source/recipe2
---
### Problem
You want user input to be used in another part of your HTML page.

### Solution
Use Angulars `ng-model` directive to bind the text input to the expression.

{% prism markup %}
{% raw %}
Enter your name: <input type="text" ng-model="name"></input>
<p>Hello {{name}}!</p>
{% endraw %}
{% endprism %}

### Discussion
Assigning "name" to the `ng-model` attribute and using the name variable in an expression will keep both in sync automatically. Typing in the text input will automatically reflect these changes in the paragraph element below.

Consider how you would implement this traditionally using jQuery:

{% prism markup %}
<html>
  <head>
    <script src="http://code.jquery.com/jquery.min.js"></script>
  </head>
  <body>
    Enter your name: <input type="text"></input>
    <p id="name"></p>

    <script>
      $(document).ready(function() {
        $("input").keypress(function() {
          $("#name").text($(this).val());
        });
      });
    </script>

  </body>
</html>
{% endprism %}

On document ready we bind to the keypress event in the text input and replace the text in the paragraph in the callback function. Using jQuery you need to deal with document ready callbacks, element selection, event binding and the context of this. Quite a lot of concepts to swallow and lines of code to maintain!
