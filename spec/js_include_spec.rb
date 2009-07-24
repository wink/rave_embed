require File.dirname(__FILE__) + '/spec_helper'

describe RaveEmbed::JsInclude do
  before do
    RaveEmbed::JsInclude.embed_js_url = 'http://wave-api.appspot.com/public/embed.js'
  end
  
  describe "constructor:" do
    before do
      @js_include = RaveEmbed::JsInclude.new(:embed_js_url => 'http://wave.federation.com/public/embed.js')
    end
    
    it "has an attribute called 'embed_js_url'" do
      @js_include.embed_js_url.should == 'http://wave.federation.com/public/embed.js'
    end
  end
  
  describe "defaults:" do
    it "'embed_js_url' defaults to RaveEmbed configured embed url" do
      @js_include = RaveEmbed::JsInclude.new
      @js_include.embed_js_url.should == 'http://wave-api.appspot.com/public/embed.js'
    end
  end
  
  describe "#to_html" do
    before { @js_include = RaveEmbed::JsInclude.new }
    
    it "outputs javascript include tag into html string" do
      @js_include.to_html.should == "<script src='http://wave-api.appspot.com/public/embed.js' type='text/javascript'></script>"
    end
  end
end