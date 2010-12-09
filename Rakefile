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