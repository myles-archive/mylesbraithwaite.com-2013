---
layout: post
title: Got another Linode & Moved the Wiki
tags: [Linode, Wiki, Munin, Hatta, Server, System Administration]
date: 2010-02-02T10:53:51
category: journal
---

I ordered a second [Linode][Linode] (a 360) on the weekend for some PHP applications ([Fever][Fever] and [DokuWiki][DokuWiki]). I have been with many VPS services and [Linode][Linode] is by far the best you can buy (shared host I will have to say [Nearly Free Speech][NFS]). It is hosted in the same data centre (Newark, NJ) so I have an internal IP address connecting both of them. I am running [Nagios][Nagios] and [Munin][Munin] on both computers ([Panda is monitoring Fox][MuninPandaFox] and [Fox is monitoring Panda][MuninFoxPanda]) that way if one goes down the other will notify me.

I also moved my [Wiki][Wiki] from [DokuWiki][DokuWiki] to [Hatta][Hatta]. Hatta is a really simple wiki engine written in Python that use Mercurial for storage. Which means I just have to clone a repository to edit a page (you can clone the [my draft wiki][DraftWikiPage] or [my published wiki][PublishedWikiPages]). I am going to miss some of the more powerful features of DokuWiki so I have started working on my own wiki engine called **Episteme**.

Episteme will have some of my favorite feature of DokuWiki, Hatta, [Confluence][Confluence], and [Yaki][Yaki].

[Linode]: http://www.linode.com/?r=489fd5146a3553db67138302f6c6d44a029cf45a "A VPS Provider"
[Fever]: http://feedafever.com/ "An online feed reader."
[DokuWiki]: http://dokuwiki.org/ "A super simple and powerful wiki engine."
[NFS]: https://www.nearlyfreespeech.net/ "NearlyFreeSpeech.NET Web Hosting"
[Munin]: http://munin.sourceforge.net/
[Nagios]: http://www.nagios.org/
[MuninPandaFox]: http://panda.mylesbraithwaite.com/munin/mylesbraithwaite.com/fox.mylesbraithwaite.com.html
[MuninFoxPanda]: http://fox.mylesbraithwaite.com/munin/mylesbraithwaite.com/panda.mylesbraithwaite.com.html
[Wiki]: http://wiki.mylesbraithwaite.com/
[Hatta]: http://hatta.sheep.art.pl/
[DraftWikiPage]: http://bitbucket.org/myles/wiki-pages/
[PublishedWikiPages]: http://wiki.mylesbraithwaite.com/hg/
[Confluence]: http://www.atlassian.com/software/confluence/
[Yaki]: http://code.google.com/p/yaki/