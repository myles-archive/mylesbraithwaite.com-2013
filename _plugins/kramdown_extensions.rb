require 'kramdown'

module Kramdown::Converter
  class Html
    def convert_a(el, indent)
      res = inner(el, indent)
      attr = el.attr.dup
      if attr['href'] =~ /^mailto:/
        attr['href'] = obfuscate('mailto') << ":" << obfuscate(attr['href'].sub(/^mailto:/, ''))
        res = obfuscate(res)
      end
      if attr['href'] =~ /^(http|https|ftp):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
        attr['rel'] = 'external'
      end
      "<a#{html_attributes(attr)}>#{res}</a>"
    end
  end
end