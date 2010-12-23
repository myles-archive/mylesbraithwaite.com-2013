require 'rubygems'
require 'grit'
include Grit

module Jekyll
  class GitActivityTag < Liquid::Tag
    
    def initialize(tag_name, text, tokens)
      super
    end
    
    def render(context)
      repo = Repo.new(File.join(Dir.getwd))
      
      commit = repo.commits.first
      
      "<a href='https://github.com/myles/mylesbraithwaite.com/commit/#{commit.id}' title='#{commit.message}'>#{commit.authored_date.strftime('%A,&nbsp;%d&nbsp;%B&nbsp;%Y&nbsp;at&nbsp;%I:%M %p')}</a> by #{commit.author.name}"
    end
  end
end

Liquid::Template.register_tag('git_recent_activity', Jekyll::GitActivityTag)