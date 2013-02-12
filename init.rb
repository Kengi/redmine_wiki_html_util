#
# vendor/plugins/redmine_wiki_html_util/init.rb
#
require 'redmine'
require 'open-uri'

Redmine::Plugin.register :redmine_gist do
  name 'Redmine Wiki HTML Util'
  author 'Arlo Carreon'
  author_url 'http://www.arlocarreon.com/blog/redmine/redmine-wiki-html-utility/'
  description 'Allows you to embedd RAW HTML into your wiki, load stylesheets and javascript.  Made for html/css/js demo wikis'
  version '0.0.1'

  Redmine::WikiFormatting::Macros.register do
    desc "Embed raw html\nUsage:\n<pre>{{html\nHTML CODE\n}}</pre>"
    macro :html do |obj, args, text|
      page = obj.page
      raise 'Page not found' if page.nil?

      # For security, only allow insertion on protected (locked) wiki pages
      if page.protected 
        #result = args.join(",")
        #result = result.gsub(/<\/?[^>]*>/, "")
        #result = CGI::unescapeHTML(result)
        result = "#{ CGI::unescapeHTML(text) }".html_safe
	return result
      else
        return "<!-- Macro removed due to wiki page being unprotected -->"
      end
    end 
  end
        
        Redmine::WikiFormatting::Macros.register do
    desc "Embed raw css"
    macro :css do |obj, args|
      page = obj.page
      raise 'Page not found' if page.nil?

      # For security, only allow insertion on protected (locked) wiki pages
      if page.protected 
        result = args[0]
        result = result.gsub(/\[/,'{')
        result = result.gsub(/\]/,'}')
        result = result.gsub(/<\/?[^>]*>/, "")
        result = "<style type=\"text/css\">"+result+"</style>"        
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
      if page.protected 
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
    macro :js do |obj, args|
      page = obj.page
      raise 'Page not found' if page.nil?

      # For security, only allow insertion on protected (locked) wiki pages
      if page.protected 
        result = "<script>"+args[0]+"</script>"
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
      if page.protected 
        result = "<script> var head = document.getElementsByTagName('head')[0], t = document.createElement('script'); t.src = "+args[0]+"; t.type='text/javascript'; head.appendChild(t); </script>"
	result = "#{ CGI::unescapeHTML(result) }".html_safe        
	return result
      else
        return "<!-- Macro removed due to wiki page being unprotected -->"
      end
    end 
  end
        
end
