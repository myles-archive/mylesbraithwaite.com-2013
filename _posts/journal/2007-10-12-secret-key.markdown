---
layout: post
title: Generate a secret key for your Django Application
category: journal
tags: [Snippets, Django, Python]
---

{% highlight python %}
	#!/usr/bin/python
	import string
	from random import choice
	
	print ''.join([choice(string.letters + string.digits + string.punctuation) for i in range(50)])
{% endhighlight %}