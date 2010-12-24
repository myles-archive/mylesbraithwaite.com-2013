require 'rubygems'
require 'grit'
include Grit

module Jekyll
  class GitDateTag < Liquid::Tag
    
    def initialize(tag_name, text, tokens)
      super
    end
    
    def render(context)
      repo = Repo.new(File.join(Dir.getwd))
      
      commit = repo.commits.first
      
      "#{commit.authored_date}"
    end
    
  end
  
  class GitRevisionHashTag < Liquid::Tag
    
    def initialize(tag_name, text, tokens)
      super
    end
    
    def render(context)
      repo = Repo.new(File.join(Dir.getwd))
      
      commit = repo.commits.first
      
      "#{commit.id}"
    end
    
  end
end

Liquid::Template.register_tag('git_date', Jekyll::GitDateTag)
Liquid::Template.register_tag('git_revision_hash', Jekyll::GitRevisionHashTag)