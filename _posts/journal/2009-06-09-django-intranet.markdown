---
layout: post
title: A Django Intranet
tags: [Django, Intranet, Projects, Applications]
date: 2009-06-09T10:03:56
category: journal
---

<div class="update">
	<p><strong>29th April 2011</strong>: I have started working on a <a href="http://mylesbraithwaite.com/journal/2011/04/what-the-frigga/" title="What The Frigga">CRM application called Frigga</a>.</p>
</div>

At work I started developing a intranet, nothing to complicated just an address
book, microblog, timesheet, and forum. I knew from the beginning of development
I wanted to release the final project open source. But it was developed in the
monolithic approach (one project for multiple ideas) so instead I am releasing
one sentence ideas:

* django-blogs: A multi-person blog similar to MovableType.
* django-bugle: A microblog. (This isn't my originally code I forked it off [Simon Willson](http://simonwillison.net/)'s [Bugle Project](http://github.com/simonw/bugle_project) and made it a more portable application.)
* django-calendar: This is a fork of my [Asgard Calendar](/calendar/).
* [django-contacts](http://github.com/myles/django-contacts/tree/master): An address book application we are using to keep track of employee contact information.
* django-forums: A Django Forum application.
* [django-issues](http://github.com/myles/django-issues/tree/master): An issue tracker.
* django-projects: An internal project tracker.
* [django-timecard](http://github.com/myles/django-timecard/tree/master): A timesheet without projects or issues.
* [django-timesheet](http://github.com/myles/django-timesheet/tree/master): A timesheet for projects, tasks, and issues.
* django-voting: An [Apache Style](http://www.apache.org/foundation/voting.html) voting application.

I still have to release django-voting, django-projects, django-forums,
django-calendar, django-bugle, and django-blogs which will probably be some
time next week and I also want to do a [Pinax](http://pinaxproject.com/) style
release at the end of the month.