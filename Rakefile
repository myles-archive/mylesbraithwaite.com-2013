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