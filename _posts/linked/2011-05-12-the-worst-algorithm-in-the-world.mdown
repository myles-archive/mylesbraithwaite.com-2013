---
title: The Worst Algorithm in the World?
layout: link
category: linked
tags:
- Python
- Algorithm
- Programming
date: 2011-05-12T14:40
link: http://bosker.wordpress.com/2011/04/29/the-worst-algorithm-in-the-world/
---

An interesting look at the worst algorithm in the world:

{% highlight python %}
#!/usr/bin/env python

import sys

def fib_rec(n):
    assert n >= 0
    if n < 2: return n
    return fib_rec(n - 2) + fib_rec(n - 1)

if __name__ == "__main__":
    print fib_rec(int(sys.argv[1]))
{% endhighlight %}

Which when calculating to forty takes one minute and seven seconds. Verses the improved version:

{% highlight python %}
#!/usr/bin/env python

import sys

def bits(n):
    bits = []
    while n > 0:
            n, bit = divmod(n, 2)
            bits.append(bit)
    bits.reverse()
    return bits

def fib_mat(n):
    assert n >= 0
    a, b, c = 1, 0, 1
    for bit in bits(n):
        a, b, c = a*a + b*b, a*b + b*c, b*b + c*c
        if bit: a, b, c = b, c, b+c
    return b

if __name__ == "__main__":
    print fib_mat(int(sys.argv[1]))
{% endhighlight %}

Which when calculating to four hundred thousand takes four seconds.

Definitely worth the read.