---
layout: link
title: How can I make VIM play typewriter sound when I write a letter?
category: linked
tags: [VIM, Linux, Mac OS X, Typewriter]
date: 2010-12-12T12:50:51
link: http://stackoverflow.com/questions/4418364/how-can-i-make-vim-play-typewriter-sound-when-i-write-a-letter/4418605#4418605
---

The best things about StackOverflow are these kind of questions that actually receive an answer and not a "I would like that information to".

{% highlight vim %}
function! PlaySound()
	silent! exec '!afpaly ~/.vim/support/my_typewriter_sound.aiff &'
endfunction
autocmd CursorMovedI * call PlaySound()
{% endhighlight %}