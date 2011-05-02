require 'slugify'

module Jekyll
  class TagIndex < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
  
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_archive.html')
      self.data['tag'] = tag
  
      tag_title_prefix = site.config['tag_title_prefix'] || 'Tag: '
      self.data['title'] = "#{tag_title_prefix}#{tag.to_s()}"
    end
  end
  
  class TagList < Page
    def initialize(site, base, dir, tags)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      
      self.process(@name)
      self.read_yaml(File.join(base, "_layouts"), 'tag_list.html')
      self.data['tags'] = tags
    end
  end
  
  class TagGenerator < Generator
    safe true
    
    def generate(site)
      site.tags.keys.each do |tag|
        write_tag_index(site, File.join('tags', "#{tag.to_s().slugify}"), tag)
      end
      
      write_tag_list(site, 'tags', site.tags.keys)
    end
  
    def write_tag_index(site, dir, tag)
      index = TagIndex.new(site, site.source, dir, tag)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
    
    def write_tag_list(site, dir, tags)
      index = TagList.new(site, site.source, dir, tags)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.static_files << index
    end
  end
end