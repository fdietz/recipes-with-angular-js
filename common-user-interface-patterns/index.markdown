---
layout: default
title: Common User Interface Patterns - Table of Contents
---
<ul class="breadcrumbs">
  <li><a href="/">Home</a></li>
  <li class="current">Common User Interface Patterns</li>
</ul>

<h2>Common User Interface Patterns</h2>

<h2>Table of Contents</h2>
<ol>
  {% sorted_for page in site.pages | sort_by:order %}
    {% if page.chapter == "common-user-interface-patterns" %}
      <li>
        <a href="{{page.url}}">{{page.title}}</a>
      </li>
    {% endif %}
  {% endsorted_for %}
</ol>