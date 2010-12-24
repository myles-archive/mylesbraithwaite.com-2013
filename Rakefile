task :default => :server

desc 'Star server with --auto'
task :server do
    jekyll('--server --auto')
end

desc 'Build site with Jekyll'
task :build do
    jekyll('--no-future')
end

command = "rsync -rtzh --progress --delete --delete _site/ "

desc 'Build and deploy to master'
task :publish => :build do
  sh command + "myles@fox:/srv/www/com_mylesbraithwaite_www/html"
end

desc 'Build and deploy to master and mirrors'
task :publish_mirrors => :publish do
  # rsync mirrors
  sh command + "nfs-myles-myles:/home/public"
  sh command + "webfaction:~/webapps/myles"
  
  # s3 mirror
  sh "s3cmd sync --acl-public _site/ s3://mylesbraithwaite.com"
end

desc 'Build and deploy to GitHub pages'
task :publish_github => :build do
  require 'grit'
  repo = Grit::Repo.init('./_site')
  repo.clone({ :quite => false, :verbose => true, :progress => true, :branch => 'master' }, "git@github.com:myles/myles.github.com.git")
  
  files = Dir.glob(File.join(Dir.getwd, "_site/**"))
  repo.add(files)
  repo.commit_all("#{Time.now}")
end

def jekyll(opts='')
    sh 'rm -fr _site/*'
    sh 'jekyll ' + opts
end

desc 'Validate the ATOM feeds.'
task :validate_atom => :build do
  sh 'find _site/feeds -name "atom.xml" | xargs xmllint --valid --noout'
end

desc 'Ping'
task :ping => [:ping_pubsubhubbub, :ping_pingomatic] do
  puts "Pinged"
end

desc 'Ping PubSubHubBub server.'
task :ping_pubsubhubbub do
  require 'cgi'
  require 'net/http'
  data = 'hub.mode=publish&hub.url=' + CGI::escape("http://mylesbraithwaite.com/atom.xml")
  http = Net::HTTP.new('pubsubhubbub.appspot.com', 80)
  resp, data = http.post('http://pubsubhubbub.appspot.com/publish', data, { 'Content-Type' => 'application/x-www-form-urlencoded' })
  puts "Ping error: #{resp}, #{data}" unless resp.code == "204"
end

desc "Ping Pingomatic server."
task :ping_pingomatic do
  require 'rubygems'
  require 'cgi'
  require 'net/http'
  http = Net::HTTP.new('pingomatic.com', 80)
  data = 'title=' + CGI::escape("Myles Braithwaite") + "&blogurl=" + CGI::escape("http://mylesbraithwaite.com/") + "&rssurl=" + CGI::escape("http://mylesbraithwaite.com/atom.xml") + "&chk_blogs=on&chk_technorati=on&chk_feedburner=on&chk_google=on&chk_bloglines=on"
  resp, data = http.get('http://pingomatic.com/ping/?' + data)
  puts "Ping error: #{resp}, #{data}" unless resp.code == "200"
end