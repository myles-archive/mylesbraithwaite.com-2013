---
title: Gob's Program in Haskell
layout: link
category: linked
tags:
- Haskell
- Arrested Development
- Gob's Program
- Programming
date: 2011-03-17T10:05
link: http://timcowlishaw.co.uk/post/3919258574/fans-of-arrested-development-will-doubtless
---

{% highlight haskell %}
import System.Exit
import Control.Monad
main = do
	putStrLn "Gob's Program: Y/N?"
	ans <- getLine
	case ans of
		"Y" -> sequence_ $ map putStr penuses
		_   -> exitSuccess

penuses = ["Penus " | _ <- [1..]]
{% endhighlight %}