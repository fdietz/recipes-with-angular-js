---
layout: default
title: Recipes with Angular.js
---
<ul class="breadcrumbs">
  <li><a href="{{ site.baseurl }}">Home</a></li>
  <li class="current">introduction</li>
</ul>

<h2>Table of Contents</h2>
<ol>
  {% sorted_for page in site.pages | sort_by:order %}
    {% if page.chapter == "introduction" %}
      <li>
        <a href="{{ site.baseurl }}{{page.url}}">{{page.title}}</a>
      </li>
    {% endif %}
  {% endsorted_for %}
</ol>