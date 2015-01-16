---
layout: recipe
title: Common User Interface Patterns - Table of Contents
chapter: common-user-interface-patterns
intro: true
---
<ul class="breadcrumbs">
  <li><a href="{{ site.baseurl }}">Home</a></li>
  <li class="current">Common User Interface Patterns</li>
</ul>

<h2>Table of Contents</h2>
<ol>
  {% sorted_for page in site.pages | sort_by:order %}
    {% if page.chapter == "common-user-interface-patterns" %}
      <li>
        <a href="{{ site.baseurl }}{{page.url}}">{{page.title}}</a>
      </li>
    {% endif %}
  {% endsorted_for %}
</ol>