---
layout: link
title: How To Safely Store A Password
category: linked
tags: [bcrypt, Security, Password]
date: 2010-12-13T16:34
link: http://codahale.com/how-to-safely-store-a-password/
---

After [Gawker](http://nakedsecurity.sophos.com/2010/12/13/gawker-gizmodo-lifehacker-password-change/) passwords were compromised it might be a good idea to look at how you are storing your passwords. Considering:

> A modern server can calculate the MD5 hash of about 330MB every second. If your users have passwords which are lowercase, alphanumeric, and 6 characters long, you can try every single possible password of that size in around 40 seconds.

You will have to use a third party library to use `bcrypt` in Python called [Bcryptor](http://pypi.python.org/pypi/Bcryptor). It has a simple enough API:

{% highlight python %}
>>> import bcryptor
>>> 
>>> hasher = bcryptor.Bcrypt()
>>> hash = haser.create('password')
>>> 
>>> haser.valid('password', hash)
True
>>> haser.valid('Password', hash)
False
{% endhighlight %}