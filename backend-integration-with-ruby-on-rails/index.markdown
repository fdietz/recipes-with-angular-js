---
layout: recipe
title: Backend Integration with Ruby on Rails
chapter: backend-integration-with-ruby-on-rails
intro: true
---
In this chapter we will have a look at using Angular.js with the Ruby on Rails framework.
<h2>Table of Contents</h2>
<ol>
  {% sorted_for page in site.pages | sort_by:order %}
    {% if page.chapter == "backend-integration-with-ruby-on-rails" %}
      <li>
        <a href="{{ site.baseurl }}{{page.url}}">{{page.title}}</a>
      </li>
    {% endif %}
  {% endsorted_for %}
</ol>
