---
layout: post
title: How to find if a directory or file exists in Bash
tags: [ Bash, Snippet, Code ]
date: 2010-11-24T14:40:51
category: journal
---

This is a quick service announcement on how to find if a directory or file exists in Bash.

{% highlight bash %}
#!/bin/bash

# Notice the '-d'
if [ -d ~/.bin-private ]; then
    echo "Your private bin exists."
else
    echo "Your private bin doesn't exists."
fi

# Notice the '-f'
if [ -f ~/.ssh/config ]; then
    echo "You have configured SSH."
else
    echo "You haven't configured SSH."
fi
{% endhighlight %}

You're Welcome.