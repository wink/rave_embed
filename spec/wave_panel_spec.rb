require File.dirname(__FILE__) + '/spec_helper'

describe RaveEmbed::WavePanel do
  before do
    RaveEmbed.public_address = "public@a.gwave.com"
    RaveEmbed.root_url = "https://wave.google.com/a/wavesandbox.com/"
    RaveEmbed.function_name = 'wavePanelInit'
    RaveEmbed.dom_id = 'waveframe'
    RaveEmbed.bg_color = nil
    RaveEmbed.color = nil
    RaveEmbed.font = nil
    RaveEmbed.font_size = nil
    RaveEmbed.is_public = true
  end
  
  describe "constructor:" do
    before do
      @wave_panel = RaveEmbed::WavePanel.new('my_wave_id',
                      :function_name => 'myFunction',
                      :dom_id => 'give_me_a_dom_id',
                      :root_url => 'http://mywave.acme.com',
                      :bg_color => 'green', 
                      :color => 'white',
                      :font => 'Arial',
                      :font_size => 12,
                      :participants => ['greg@waveexample.com', 'bob@waveexample.com'],
                      :is_public => false)
    end
    
    it "has an attribute called 'id'" do
      @wave_panel.wave_id.should == 'my_wave_id'
    end
    
    it "has an attribute called 'function_name'" do
      @wave_panel.function_name.should == 'myFunction'
    end
    
    it "has an attribute called 'dom_id'" do
      @wave_panel.dom_id.should == 'give_me_a_dom_id'
    end
    
    it "has an attribute called 'root_url'" do
      @wave_panel.root_url.should == 'http://mywave.acme.com'
    end
    
    it "has an attribute called 'bg_color'" do
      @wave_panel.bg_color.should == 'green'
    end
    
    it "has an attribute called 'color'" do
      @wave_panel.color.should == 'white'
    end
    
    it "has an attribute called 'font'" do
      @wave_panel.font.should == 'Arial'
    end
    
    it "has an attribute called 'font_size'" do
      @wave_panel.font_size.should == 12
    end
    
    it "has an attribute called 'participants'" do
      @wave_panel.participants.should == ['greg@waveexample.com', 'bob@waveexample.com']
    end
    
    it "has an attribute called 'is_public'" do
      @wave_panel.is_public.should == false
    end
    
    describe "when id is blank" do
      it "raises an error with empty string" do
        lambda { RaveEmbed::WavePanel.new('') }.should raise_error
        @wave_panel = RaveEmbed::WavePanel.new('my_id')
        lambda { @wave_panel.wave_id = '' }.should raise_error
      end
      
      it "raises an error with nil" do
        lambda { RaveEmbed::WavePanel.new }.should raise_error
        lambda { RaveEmbed::WavePanel.new(nil) }.should raise_error
        
        @wave_panel = RaveEmbed::WavePanel.new('my_id')
        lambda { @wave_panel.wave_id = nil }.should raise_error
      end
    end
    
    describe "defaults:" do
      before do
        @wave_panel = RaveEmbed::WavePanel.new('my_wave_id')
      end
      
      it "'function_name' defaults to the global RaveEmbed function name" do
        @wave_panel.function_name.should == 'wavePanelInit'
      end
      
      it "'dom_id' defaults to the global RaveEmbed dom id" do
        @wave_panel.dom_id.should == 'waveframe'
      end
      
      it "'root_url' defaults to the global RaveEmbed root url" do
        @wave_panel.root_url.should == "https://wave.google.com/a/wavesandbox.com/"
      end
      
      %w(bg_color color font font_size).each do |attr|
        it "'#{attr}' defaults to the global RaveEmbed #{attr} value" do
          @wave_panel.send(attr).should == nil
        end
      end
      
      it "'participants' default to nobody if the wave is private" do
        @wave_panel.is_public = false
        @wave_panel.participants.should == []
      end
      
      it "'participants' default to only the public address if the wave is public" do
        @wave_panel.is_public = true
        @wave_panel.participants.should == ["public@a.gwave.com"]
      end
      
      it "'is_public' defaults to the global RaveEmbed is_public value" do
        @wave_panel.is_public.should == true
      end
    end
  end
  
  describe "when public:" do
    before do
      @wave_panel = RaveEmbed::WavePanel.new('my_id', :participants => ['bob@waveexample.com', 'sue@waveexample.com'])
    end
    
    it "participants include the public address" do
      @wave_panel.participants.should include("public@a.gwave.com")
    end
  end
  
  describe "#to_html" do
    describe "with no configuration:" do
      before do
        @wave_panel = RaveEmbed::WavePanel.new('my_id')
      end
      
      it "produces an html/javascript tag that can be embedded into a page" do
        @wave_panel.to_html.should == load_fixture('hello_world.html')
      end
    end
    
    describe "with full configuration" do
      before do
        @wave_panel = RaveEmbed::WavePanel.new('my_id',
                        :function_name => 'myFunction',
                        :dom_id => 'give_me_a_dom_id',
                        :root_url => 'http://mywave.acme.com',
                        :bg_color => 'green', 
                        :color => 'white',
                        :font => 'Arial',
                        :font_size => 12)
      end
      
      it "produces a fully configured wave html/javascript tag that can be embedded into a page" do
        @wave_panel.to_html.should == load_fixture('fully_configured.html')
      end
    end  
    
    describe "with custom font and default colors" do
      before do
        @wave_panel = RaveEmbed::WavePanel.new('my_id', :font => 'Arial', :font_size => 12)
      end

      it "produces a customized font wave html/javascript tag that can be embedded into a page" do
        @wave_panel.to_html.should == load_fixture('custom_font_default_color.html')
      end
    end
  end
  
end