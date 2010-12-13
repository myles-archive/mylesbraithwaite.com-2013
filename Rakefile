task :default => :server

desc 'Star server with --auto'
task :server do
    jekyll('--server --auto')
end

desc 'Build site with Jekyll'
task :build do
    jekyll('--no-future')
end

desc 'Build and deploy'
task :publish => :build do
    sh "rsync -rtzh --progress --delete --delete _site/ myles@fox:/srv/www/com_mylesbraithwaite_www/html"
end

def jekyll(opts='')
    sh 'rm -fr _site/*'
    sh 'jekyll ' + opts
end

JOURNAL_TEMPLATE = <<-EOS
---
layout: post
title: #{args.title}
tags: 
date: #{ Time.now.strftime('%Y-%m-%dT%X') }
category: journal
---

EOS

LINKED_TEMPLATE = <<-EOS
---
layout: link
title: #{args.title}
tags: 
date: #{ Time.now.strftime('%Y-%m-%dT%X') }
category: linked
link: #{args.link}
---

EOS

namespace "create" do
  desc "New journal post."
  task :journal, [:title, :slug] do |t, args|
    args.with_defaults(:title => "Untitled", :slug => "untitled")
    
    filename = "#{ Time.now.strftime('%Y-%m-%d') }-#{args.slug}.mdown"
    filepath = File.join('_posts/', filename)
    
    if File.exist?(filepath)
      raise "Post already exists."
    end
    
    post = File.open(filepath, 'w')
    post.puts JOURNAL_TEMPLATE
    post.close
    
    sh "$EDITOR #{filepath}"
  end
  
  desc "New linked post."
  task :linked, [:title, :slug, :link] do |t, args|
    args.with_defaults(:title => "Untitled", :slug => "untitled", :link => "http://example.com/")
    
    filename = "#{ Time.now.strftime('%Y-%m-%d') }-#{args.slug}.mdown"
    filepath = File.join('_posts/', filename)
    
    if File.exist?(filepath)
      raise "Post already exists."
    end
    
    post = File.open(filepath, 'w')
    post.puts LINKED_TEMPLATE
    post.close
    
    sh "$EDITOR #{filepath}"
  end
end

desc 'Ping PubSubHubBub server.'
task :ping do
  require 'cgi'
  require 'net/http'
  printHeader 'Pinging pubsubhubbub server'
  data = 'hub.mode=publish&hub.url=' + CGI::escape("http://mylesbraithwaite.com/atom.xml")
  http = Net::HTTP.new('pubsubhubbub.appspot.com', 80)
  resp, data = http.post('http://pubsubhubbub.appspot.com/publish', data, { 'Content-Type' => 'application/x-www-form-urlencoded' })
  puts "Ping error: #{resp}, #{data}" unless resp.code == "204"
end

desc "Ping Pingomatic server."
task :pingomatic do
  require 'rubygems'
  require 'cgi'
  require 'net/http'
  printHeader 'Pinging Pingomatic server'
  http = Net::HTTP.nwe('pingomatic.com', 80)
  data = 'title=' + CGI::escape("Myles Braithwaite") + "&blogurl=" + CGI::escape("http://mylesbraithwaite.com/") + "&rssurl=" + CGI::escape("http://mylesbraithwaite.com/atom.xml") + "&chk_blogs=on&chk_technorati=on&chk_feedburner=on&chk_google=on&chk_bloglines=on"
  resp, data = http.get('http://pingomatic.com/ping/?' + data)
  puts "Ping error: #{resp}, #{data}" unless resp.code == "200"
end