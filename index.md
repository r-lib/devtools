---
layout: base
title: devtools
subtitle: Tools to make R package development easier
---

{% capture left %}

These pages are about the set of packages I have helped to build that make package development easier in R. They include:

* `devtools`
* `testthat`
* `roxygen2` (developed in collaboration with Peter Danenberg and Manuel Eugster)
* `profr`

{% endcapture %}

{% capture right %}

## News

<ul>
{% for post in site.posts %}
  <li><a href="{{ post.url }}">{{ post.title }}</a></li>
{% endfor %}
</ul>

## Mailing list

You can of course ask package development questions on R-devel, but if you'd like to participate in mailing list focussed on this particular style of package development, please sign up for the rdevtools mailing list:

<form action="http://groups.google.com/group/rdevtools/boxsubscribe">
  Your email address: <input type="text" name="email" /> <input type="submit" value="Subscribe" />
</form>

You must be a member to post messages, but anyone can [read the archived discussions](http://groups.google.com/group/rdevtools).

{% endcapture %}

<div class="ten columns">
  {{ left | markdownify }}
</div>
<div class="five columns offset-by-one">
  <div class="sidebar">
  {{ right | markdownify  }}
  </div>
</div>
