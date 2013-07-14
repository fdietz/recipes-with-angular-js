require "cgi"

module Jekyll
  class JsFiddle < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
    end

    def escape(value)
      value = CGI.escapeHTML(value)

      # escape {{ (double curly braces)
      # since liquid template engine would interpret it as a liquid tag
      value.gsub("{{", '&#123;&#123;'). 
            gsub("}}", '&#125;&#125;');
    end

    def hidden_field(name, value)
      <<-EOF
      <input type="hidden" name="#{name}" value="#{escape(value)}"></input>
      EOF
    end

    def resource_path
      "https://ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular.min.js"
    end

    def css_resource_path
      '<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">'
    end

    def template(html_content, js_content)
      <<-EOF
      <form class="jsfiddle" method="post" action="http://jsfiddle.net/api/post/library/pure/" target="_blank">
        #{hidden_field('html', html_content) if html_content}
        #{hidden_field('js', js_content) if js_content}
        #{hidden_field('resources', resource_path)}
        <button class="btn small btn-primary">Edit in jsfiddle</button>
      </form>
      EOF
    end

    def html_path
      "#{File.dirname(__FILE__)}/../#{@path}/index.html"
    end

    def js_path
      "#{File.dirname(__FILE__)}/../#{@path}/app.js"
    end

    def render(context)
      @path = context.environments.first["page"]["source_path"]

      if @path
        html_content = IO.read(html_path)
        js_content = IO.read(js_path) if File.exist?(js_path)
        template(html_content, js_content).strip
      else
        "Error processing input. Expected syntax: {% jsfiddle [html] %}"
      end
    end
  end
end

Liquid::Template.register_tag('jsfiddle', Jekyll::JsFiddle)