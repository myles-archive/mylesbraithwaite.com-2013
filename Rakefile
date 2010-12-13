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
  command = "rsync -rtzh --progress --delete --delete _site/ "
  
  sh command + "myles@fox:/srv/www/com_mylesbraithwaite_www/html"
  sh command + "nfs-myles-myles:/home/public"
end

def jekyll(opts='')
    sh 'rm -fr _site/*'
    sh 'jekyll ' + opts
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
