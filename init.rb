#
# vendor/plugins/redmine_wiki_html_util/init.rb
#
require 'redmine'
require 'open-uri'

Redmine::Plugin.register :redmine_wiki_html_util do
  name 'Redmine Wiki HTML Util'
  author 'Arlo Carreon'
  author_url 'http://www.arlocarreon.com/blog/redmine/redmine-wiki-html-utility/'
  description 'Allows you to embedd RAW HTML into your wiki, load stylesheets and javascript.  Made for html/css/js demo wikis'
  version '0.0.1'

  Redmine::WikiFormatting::Macros.register do
    desc "Embed raw html\nUsage:\n<pre>{{html\nHTML CODE\n}}</pre>"
    macro :html, :parse_args => false do |obj, args, text|
      page = obj.page
      raise 'Page not found' if page.nil?

      # For security, only allow insertion on protected (locked) wiki pages
      if true || page.protected
        content = text || args 
        result = "#{ CGI::unescapeHTML(content) }".html_safe
        return result
      else
        return "<!-- Macro removed due to wiki page being unprotected -->"
      end
    end 
  end
        
  Redmine::WikiFormatting::Macros.register do
    desc "Embed raw css"
    macro :css, :parse_args => false do |obj, args, text|
      page = obj.page
      raise 'Page not found' if page.nil?

      # For security, only allow insertion on protected (locked) wiki pages
      if true || page.protected 
        content = text || args 
        content = "<style type=\"text/css\">"+content+"</style>"        
        result = "#{ CGI::unescapeHTML(content) }".html_safe
        return result
      else
        return "<!-- Macro removed due to wiki page being unprotected -->"
      end
    end 
  end
        
  Redmine::WikiFormatting::Macros.register do
    desc "Insert a CSS file into the DOM\nUsage:\n<pre>{{css_url(http://css.url)}}</pre>"
    macro :css_url do |obj, args|
      page = obj.page
      raise 'Page not found' if page.nil?

      # For security, only allow insertion on protected (locked) wiki pages
      if true || page.protected 
        result = "<script> var head = document.getElementsByTagName('head')[0], t = document.createElement('link'); t.href = "+args[0]+"; t.media='all'; t.rel='stylesheet'; head.appendChild(t); </script>"
        result = "#{ CGI::unescapeHTML(result) }".html_safe
        return result
      else
        return "<!-- Macro removed due to wiki page being unprotected -->"
      end
    end 
  end
        
  Redmine::WikiFormatting::Macros.register do
    desc "Embed raw js"
    macro :js, :parse_args => false do |obj, args, text|
      page = obj.page
      raise 'Page not found' if page.nil?

      # For security, only allow insertion on protected (locked) wiki pages
      if true || page.protected
        content = text || args 
        content = "<script>"+content+"</script>"
        result = "#{ CGI::unescapeHTML(content) }".html_safe
        return result
      else
        return "<!-- Macro removed due to wiki page being unprotected -->"
      end
    end 
  end
        
  Redmine::WikiFormatting::Macros.register do
    desc "Insert a JS file into the DOM\nUsage:\n<pre>{{js_url(http://js.url)}}</pre>"
    macro :js_url do |obj, args|
      page = obj.page
      raise 'Page not found' if page.nil?

      # For security, only allow insertion on protected (locked) wiki pages
      if true || page.protected 
        result = "<script> var head = document.getElementsByTagName('head')[0], t = document.createElement('script'); t.src = "+args[0]+"; t.type='text/javascript'; head.appendChild(t); </script>"
        result = "#{ CGI::unescapeHTML(result) }".html_safe
        return result
      else
        return "<!-- Macro removed due to wiki page being unprotected -->"
      end
    end 
  end

  Redmine::WikiFormatting::Macros.register do
    desc "Embed raw css class\nUsage:\n<pre>{{class_text(classname, text)}}</pre>"
    macro :class_text do |obj, args|
      page = obj.page
      raise 'Page not found' if page.nil?

      # For security, only allow insertion on protected (locked) wiki pages
      if true || page.protected
        content = args[1]
        content.gsub! /(<|&lt;)/, "< "
        content.gsub! /(>|&gt;)/, " >"
        result = "<span class=\""+args[0]+"\">"+content+"</span>"
        result = "#{ CGI::unescapeHTML(result) }".html_safe
        return result
      else
        return "<!-- Macro removed due to wiki page being unprotected -->"
      end
    end 
  end

  Redmine::WikiFormatting::Macros.register do
    desc "Info"
    macro :info, :parse_args => false do |obj, args, text|
      page = obj.page
      raise 'Page not found' if page.nil?

      o = '<span class="wiki_extensions_lastupdated_at">'
      o << l(:label_updated_time, time_tag(page.updated_on))
      o << '</span>'
      o << ' '
      o << '<span class="wiki_extensions_lastupdated_by">'
      o << link_to_user(obj.author)
      o << '</span>'
      o.html_safe
    end
  end

  Redmine::WikiFormatting::Macros.register do
    desc "Info"
    macro :fb, :parse_args => false do |obj, args, text|
      page = obj.page
      raise 'Page not found' if page.nil?
      fb_id = text || args
      fb_url = "http://fogbugz.gdc-tech.com/fogbugz/default.asp?%s" % [fb_id]
      o = link_to fb_id, fb_url
      o.html_safe
    end
  end

end
