---
layout: recipe
title: Consuming External Services
chapter: consuming-external-services
intro: true
---
Angular has built-in support for communication with remote HTTP servers. The [$http](http://docs.angularjs.org/api/ng.$http) service handles low-level AJAX requests via the browser's [XMLHttpRequest](http://en.wikipedia.org/wiki/XMLHttpRequest) object or via [JSONP](http://en.wikipedia.org/wiki/JSONP). The [$resource](http://docs.angularjs.org/api/ngResource.$resource) service lets you interact with RESTful data sources and provides high-level behaviors which naturally map to RESTful resources.

<h2>Table of Contents</h2>
<ol>
  {% sorted_for page in site.pages | sort_by:order %}
    {% if page.chapter == "consuming-external-services" %}
      <li>
        <a href="{{ site.baseurl }}{{page.url}}">{{page.title}}</a>
      </li>
    {% endif %}
  {% endsorted_for %}
</ol>