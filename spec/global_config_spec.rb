require File.dirname(__FILE__) + '/spec_helper'

describe RaveEmbed::WavePanel do
  describe "with custom site wide configuration" do
    
    before do
      class_instance = RaveEmbed::WavePanel
      
      class_instance.g_root_url = "http://mywave.acme.com"
      class_instance.g_dom_id = 'give_me_a_dom_id'
      class_instance.g_bg_color = 'green'
      class_instance.g_color = 'white'
      class_instance.g_font = 'Arial'
      class_instance.g_font_size = '12pt'
      class_instance.g_is_public = true
      class_instance.g_width = '800px'
      class_instance.g_height = '90%'
      class_instance.g_jquery = true
      @wave_panel = class_instance.new('my_id')
    end
    
    it "produces an html/javascript tag with all site-wide configs" do
      @wave_panel.to_html.should == load_fixture('fully_configured.html')
    end
  end
end