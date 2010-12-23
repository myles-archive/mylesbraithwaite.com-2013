module Jekyll
  module Filters
    def slugify(input)
      input.to_s().slugify
    end
  end
end