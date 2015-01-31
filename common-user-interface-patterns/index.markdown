---
layout: recipe
title: Common User Interface Patterns
chapter: common-user-interface-patterns
intro: true
---

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