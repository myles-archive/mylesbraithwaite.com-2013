require 'slugify'

module Jekyll
  class ArchiveTagGenerator < Generator
    safe true
    
    def generate(site)
      collate_by_tag(site.posts).each do |tag, posts|
        page = ArchiveTagPage.new(site, tag, posts)
        site.pages << page
      end
    end
    
    private
    
    def collate_by_tag(posts)
      collated = {}
      
      posts.each do |post|
        post.tags.each do |tag|
          if collated.has_key? tag
            collated[tag] << post
          else
            collated[tag] = [post]
          end
        end
      end
      collated
    end
  end
  
  class ArchiveTagPage
    include Convertible
    
    attr_accessor :site, :pager, :name, :ext, :basename, :dir, :data, :content, :output
    
    # Initialize new ArchivePage
    #    +site+ is the Site
    #    +tag+ is the Tag
    #    +posts+ is the list of posts in that tag
    #
    # Returns <ArchivePage>
    def initialize(site, tag, posts)
      @site = site
      @tag = tag
      self.ext = ".html"
      self.basename = "index"
      self.content = "{% include post_list_archive.html %}"
      self.data = {
        'layout' => 'archive',
        'type' => 'archive',
        'title' => "Archive for #{tag}",
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
        "paginator" => self.to_liquid
      }.deep_merge(site_payload)
      do_layout(payload, layouts)
    end
    
    def url
      File.join("/tags/", @tag.to_s().slugify, "index.html")
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
    def write(dest_perfix, dest_suffix = nil)
      dest = dest_perfix
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