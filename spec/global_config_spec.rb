require File.dirname(__FILE__) + '/spec_helper'

describe RaveEmbed::WavePanel do
  describe "with custom site wide configuration" do
    
    before do
      RaveEmbed::WavePanel.g_root_url = "http://mywave.acme.com"
      RaveEmbed::WavePanel.g_function_name = 'myFunction'
      RaveEmbed::WavePanel.g_dom_id = 'give_me_a_dom_id'
      RaveEmbed::WavePanel.g_bg_color = 'green'
      RaveEmbed::WavePanel.g_color = 'white'
      RaveEmbed::WavePanel.g_font = 'Arial'
      RaveEmbed::WavePanel.g_font_size = 12
      RaveEmbed::WavePanel.g_is_public = true
      @wave_panel = RaveEmbed::WavePanel.new('my_id')
    end
    
    it "produces an html/javascript tag with all site-wide configs" do
      @wave_panel.to_html.should == load_fixture('fully_configured.html')
    end
  end
end