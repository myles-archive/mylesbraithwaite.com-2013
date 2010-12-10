# Archive generation plugin for Jekyll
#
# By Ilkka <https://github.com/ilkka/ilkka.github.com/blob/source/_plugins/archives.rb>
# 

module Jekyll
  class ArchiveGenerator < Generator
    safe true
    
    def generate(site)
      collate_by_month(site.posts).each do |month, posts|
        page = ArchivePage.new(site, month, posts)
        site.pages << page
      end
    end
    
    private
    
    def collate_by_month(posts)
      collated = {}
      posts.each do |post|
        if post.categories
          key = "#{post.categories}/#{post.date.year}/#{post.date.strftime('%m')}"
        else
          key = "#{post.date.year}/#{post.date.strftime('%m')}"
        end
        if collated.has_key? key
          collated[key] << post
        else
          collated[key] = [post]
        end
      end
      collated
    end
  end
  
  class ArchivePage
    include Convertible
    
    attr_accessor :site, :pager, :name, :ext, :basename, :dir, :data, :content, :output
    
    # Initialize new ArchivePage
    #   +site+ is the Site
    #   +month+ is the month
    #   +posts+ is the list of posts for the month
    #
    # Returns <ArchivePage>
    def initialize(site, month, posts)
      @site = site
      @month = month
      self.ext = '.html'
      self.basename = 'index'
      self.content = <<-EOS
<ul>
{% for post in page.posts %}
<li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
{% endfor %}
</ul>
EOS
      self.data = {
        'layout' => 'archive',
        'type' => 'archive',
        'title' => "Archive for #{month}",
        'posts' => posts
      }
    end
    
    # Add any necessary layouts
    #   +layouts+ is a Hash of {"name" => "layout"}
    #   +site_payload+ is the site payload hash
    #
    # Returns nothing
    def render(layouts, site_payload)
      payload = {
        "page" => self.to_liquid,
        "paginator" => pager.to_liquid
      }.deep_merge(site_payload)
      do_layout(payload, layouts)
    end
    
    def url
      File.join("/", @month, "index.html")
    end
    
    def to_liquid
      self.data.deep_merge({
        "url" => self.url,
        "content" => self.content
      })
    end
    
    # Write the generated page file to the destination directory.
    #   +dest_prefix+ is the String path to the destination dir
    #   +dest_suffix+ is a suffix path to the destination dir
    #
    # Returns nothing
    def write(dest_prefix, dest_suffix = nil)
      dest = dest_prefix
      dest = File.join(dest, dest_suffix) if dest_suffix
      # The url needs to be unescaped in order to preserve the
      # correct filename
      path = File.join(dest, CGI.unescape(self.url))
      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, 'w') do |f|
        f.write(self.output)
      end
    end
    
    def html?
      true
    end
  end
end