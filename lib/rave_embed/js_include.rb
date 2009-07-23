class RaveEmbed
  class JsInclude
    attr_accessor :embed_js_url
    
    def initialize(embed_js_url = RaveEmbed.embed_js_url)
      @embed_js_url = embed_js_url
    end
    
    def to_html
      "<script src='#{embed_js_url}' type='text/javascript'></script>"
    end
  end
end