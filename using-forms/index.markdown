---
layout: default
title: Using Forms - Table of Contents
---
<ul class="breadcrumbs">
  <li><a href="/">Home</a></li>
  <li class="current">Using Forms</li>
</ul>

<h2>Using Forms</h2>

Every website eventually uses some kind of form for users to enter data. Angular makes it particularly easy to implement client-side form validations to give immediate feedback for an improved user experience.

<h2>Table of Contents</h2>
<ol>
  {% sorted_for page in site.pages | sort_by:order %}
    {% if page.chapter == "using-forms" %}
      <li>
        <a href="{{page.url}}">{{page.title}}</a>
      </li>
    {% endif %}
  {% endsorted_for %}
</ol>