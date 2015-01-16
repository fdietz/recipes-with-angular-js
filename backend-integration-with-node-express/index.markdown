---
layout: recipe
title: Backend Integration with Node Express - Table of Contents
chapter: backend-integration-with-node-express
intro: true
---
<ul class="breadcrumbs">
  <li><a href="{{ site.baseurl }}">Home</a></li>
  <li class="current">Backend Integration with Node Express</li>
</ul>

In this chapter we will have a look into solving common problems when combining Angular.js with the Node.js [Express](http://expressjs.com/) framework. The examples used in this chapter are based on a Contacts app to manage a list of contacts. As an extra we use MongoDB as a backend for our contacts since it requires further customization to make it work in conjunction with Angular's `$resource` service.

<h2>Table of Contents</h2>
<ol>
  {% sorted_for page in site.pages | sort_by:order %}
    {% if page.chapter == "backend-integration-with-node-express" %}
      <li>
        <a href="{{ site.baseurl }}{{page.url}}">{{page.title}}</a>
      </li>
    {% endif %}
  {% endsorted_for %}
</ol>
