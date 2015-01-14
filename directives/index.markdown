---
layout: overview
chapter: directives
title: Directives
---
<ul class="breadcrumbs">
  <li><a href="{{ site.baseurl }}">Home</a></li>
  <li class="current">directives</li>
</ul>

<!-- <h2>Directives</h2> -->

Directives are one of the most powerful concepts in Angular since they let you invent new HTML elements specific to your application. This allows you to create reusable components which encapsulate complex DOM structures, stylesheets and even behavior.

<h2>Table of Contents</h2>
<ol>
  {% sorted_for page in site.pages | sort_by:order %}
    {% if page.chapter == "directives" %}
      <li>
        <a href="{{ site.baseurl }}{{page.url}}">{{page.title}}</a>
      </li>
    {% endif %}
  {% endsorted_for %}
</ol>