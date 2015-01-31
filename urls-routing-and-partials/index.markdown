---
layout: recipe
title: URLs, Routing and Partials - Table of Contents
chapter: urls-routing-and-partials
intro: true
---
The [$location service](http://docs.angularjs.org/guide/dev_guide.services.$location) in Angular.js parses the current browser URL and makes it available to your application. Changes in either the browser address bar or the `$location` service will be kept in sync.

Depending on the configuration, the `$location` service behaves differently and has different requirements for your application. We will first look into client-side routing with hashbang URLs since it is the default mode, and then later, look at the new HTML5-based routing.

<h2>Table of Contents</h2>
<ol>
  {% sorted_for page in site.pages | sort_by:order %}
    {% if page.chapter == "urls-routing-and-partials" %}
      <li>
        <a href="{{ site.baseurl }}{{page.url}}">{{page.title}}</a>
      </li>
    {% endif %}
  {% endsorted_for %}
</ol>