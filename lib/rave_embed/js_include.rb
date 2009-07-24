module RaveEmbed
  class JsInclude
    include ClassLevelInheritableAttributes
    
    cattr_inheritable :embed_js_url
    @embed_js_url = 'http://wave-api.appspot.com/public/embed.js'
    
    attr_accessor :embed_js_url
    
    def initialize(opts = {})
      @embed_js_url = opts[:embed_js_url] || JsInclude.embed_js_url
    end
    
    def to_html
      "<script src='#{embed_js_url}' type='text/javascript'></script>"
    end
  end
end