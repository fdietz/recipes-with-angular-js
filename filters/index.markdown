---
layout: overview
chapter: filters
title: Filters
intro: true
---
Angular Filters are typically used to format expressions in bindings in your template. They transform the input data to a new formatted data type.

<h2>Table of Contents</h2>
<ol>
  {% sorted_for page in site.pages | sort_by:order %}
    {% if page.chapter == "filters" %}
      <li>
        <a href="{{ site.baseurl }}{{page.url}}">{{page.title}}</a>
      </li>
    {% endif %}
  {% endsorted_for %}
</ol>