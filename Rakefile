task :default => :server

desc 'Star server with --auto'
task :server do
    jekyll('--server --auto')
end

desc 'Build site with Jekyll'
task :build do
    jekyll('--no-future')
end

desc "Deploy to Master"
task :deploy => :"deploy:master"

namespace :deploy do
  
  desc "Deploy to Master"
  task :master => :build do
    rsync "myles@fox:/srv/www/com_mylesbraithwaite_www/html"
  end
  
  desc "Deploy to NearlyFreeSpeech.Net"
  task :nfs => :build do
    rsync "nfs-myles-myles:/home/public"
  end
  
  desc "Deploy to Webfaction"
  task :webfaction => :build do
    rsync "webfaction:~/webapps/myles"
  end

  desc "Deploy to SDF"
  task :sdf => :build do
    rsync "sdf.org:/udd/m/myles/html"
  end
  
  desc "Deploy to S3"
  task :s3 => :build do
    s3cmd "s3://mylesbraithwaite.com"
  end
  
  desc 'Deploy to MobileMe service.'
  task :mobileme => :build do
    rsync "/Volumes/iDisk/Sites/mylesbraithwaite.com/"
  end
  
  desc 'Deploy to Heroku.'
  task :heroku do
    sh "rm -fr _site/"
    sh "mkdir _site/"
    sh "git checkout heroku"
    jekyll('--no-future')
    sh "git add -f _site/"
    sh "git commit -m 'Hello, World'"
    sh "git rebase master"
    sh "git add -f _site/"
    sh "git commit -a -m 'Hello, World'"
    sh "git pull heroku master"
    sh "git commit -a -m 'Hello, World'"
    sh "git push heroku heroku:master"
    sh "git checkout master"
    sh "mkdir _site/"
  end
  
  desc 'Deploy to GitHub page.'
  task :github => :build do
    sh "cd _site/"
    sh "git init ."
    sh "git pull git@github.com:myles/myles.github.com.git:master"
    sh "git add ."
    sh "git commit -m 'Hello, World!'"
    sh "git push git@github.com:myles/myles.github.com.git:master"
  end
  
  desc "Deploy to Mirrors"
  task :mirrors => [:nfs, :webfaction, :s3]
  
  desc "Git based Mirrors"
  task :git_mirrors => [:heroku, :github]
  
  desc "Deploy to All"
  task :all => [:master, :mirrors]
  
  def rsync(location)
    sh "rsync -rtzh --progress --delete --delete _site/ #{location}/"
  end
  
  def s3cmd(location)
    sh "s3cmd sync --acl-public --delete-removed _site/ #{location}/"
  end
end

desc "Create a new post"
namespace :create do
  desc "Create a new blog post"
  task :blog do
    print "Please enter in the title of the blog post: "
    title = $stdin.gets.chomp.strip
    name = title.gsub(/\s+/, '-')
    name = name.gsub(/[^a-zA-Z0-9_-]/, "").downcase
    time = Time.now.strftime("%Y-%m-%d")
    date = Time.now.strftime("%Y-%m-%dT%H:%M")
    File.open("_posts/journal/#{time}-#{name}.mdown", "w+") do |file|
      file.puts <<-EOF
---
title: #{title}
layout: post
category: journal
tags: [  ]
date: #{date}
---
      EOF
    end
    puts "Created '_posts/journal/#{time}-#{name}.mdown'"
  end
  
  desc "Create a new link post"
  task :link do
    print "Please enter in the title of the link post: "
    title = $stdin.gets.chomp.strip
    print "Please enter in the link to the link post: "
    link = $stdin.gets.chomp.strip
    name = title.gsub(/\s+/, '-')
    name = name.gsub(/[^a-zA-Z0-9_-]/, "").downcase
    time = Time.now.strftime("%Y-%m-%d")
    date = Time.now.strftime("%Y-%m-%dT%H:%M")
    File.open("_posts/linked/#{time}-#{name}.mdown", "w+") do |file|
      file.puts <<-EOF
---
title: #{title}
layout: link
category: linked
tags: [  ]
date: #{date}
link: #{link}
---
      EOF
    end
    puts "Created '_posts/linked/#{time}-#{name}.mdown'"
  end
end

def jekyll(opts='')
    sh 'rm -fr _site/*'
    sh 'jekyll ' + opts
end

desc 'Validate the ATOM feeds.'
task :validate_atom => :build do
  sh 'find _site/feeds -name "*.xml" | xargs xmllint --valid --noout'
end

desc 'Ping'
task :ping => [:ping_pubsubhubbub, :ping_pingomatic] do
  puts "Pinged"
end

desc 'Ping PubSubHubBub server.'
task :ping_pubsubhubbub do
  require 'cgi'
  require 'net/http'
  data = 'hub.mode=publish&hub.url=' + CGI::escape("http://mylesbraithwaite.com/feeds/atom.xml")
  http = Net::HTTP.new('pubsubhubbub.appspot.com', 80)
  resp, data = http.post('/publish', data, { 'Content-Type' => 'application/x-www-form-urlencoded' })
  puts "Ping error: #{resp}, #{data}" unless resp.code == "204"
end

desc "Ping Pingomatic server."
task :ping_pingomatic do
  require 'rubygems'
  require 'cgi'
  require 'net/http'
  http = Net::HTTP.new('pingomatic.com', 80)
  data = 'title=' + CGI::escape("Myles Braithwaite") + "&blogurl=" + CGI::escape("http://mylesbraithwaite.com/") + "&rssurl=" + CGI::escape("http://mylesbraithwaite.com/feeds/atom.xml") + "&chk_blogs=on&chk_technorati=on&chk_feedburner=on&chk_google=on&chk_bloglines=on"
  resp, data = http.get('/ping/?' + data)
  puts "Ping error: #{resp}, #{data}" unless resp.code == "200"
end

desc "See if the mirrors are out of date."
task :check_mirrors => :build do
  require 'net/http'
  require 'yaml'
  master_version = File.open('_site/VERSION.yml') { |yf| YAML::load(yf) }
  
  mirrors = [
    'mylesbraithwaite.com',
    'myles.nfshost.com',
    'myles.webfactional.com',
    # 'myles.github.com', <- Disabled because haven't got it working yet.
    'mylesbraithwaite.com.nyud.net'
  ]
  
  for mirror in mirrors do
    puts "Testing '#{mirror}'."
    http = Net::HTTP.new(mirror, 80)
    resp, data = http.get('/VERSION.yml')
    version = YAML::load(data)
    if version['git_reversion'] == master_version['git_reversion']
      puts "#{mirror} is up to date."
    else
      puts "#{mirror} is out of date."
    end
  end
end

desc "Five Longest Posts"
task :longest do
  sh 'wc -w _posts/*/* | sort | tail -n6'
end
