---
layout: default
title: Backend Integration with Ruby on Rails - Table of Contents
---
<ul class="breadcrumbs">
  <li><a href="/">Home</a></li>
  <li class="current">Backend Integration with Ruby on Rails</li>
</ul>

<h2>Backend Integration with Ruby on Rails</h2>

<h2>Table of Contents</h2>
<ol>
  {% sorted_for page in site.pages | sort_by:order %}
    {% if page.chapter == "backend-integration-with-ruby-on-rails" %}
      <li>
        <a href="{{page.url}}">{{page.title}}</a>
      </li>
    {% endif %}
  {% endsorted_for %}
</ol>
