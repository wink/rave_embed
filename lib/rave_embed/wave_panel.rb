class RaveEmbed
  class WavePanel
    
    attr_accessor :wave_id, :function_name, :dom_id, :root_url, :bg_color, :color, :font, :font_size, :participants, :is_public
  
    def initialize(wave_id_str, opts = {})
      @wave_id       = wave_id_str
      @function_name = opts[:function_name] || RaveEmbed.function_name
      @dom_id        = opts[:dom_id]        || RaveEmbed.dom_id
      @root_url      = opts[:root_url]      || RaveEmbed.root_url
      @bg_color      = opts[:bg_color]      || RaveEmbed.bg_color
      @color         = opts[:color]         || RaveEmbed.color
      @font          = opts[:font]          || RaveEmbed.font
      @font_size     = opts[:font_size]     || RaveEmbed.font_size
      @is_public     = opts[:is_public].nil? or opts[:is_public]
      @participants  = opts[:participants]  || []
      validate
    end
    
    def wave_id=(wave_id_str)
      @wave_id = wave_id_str
      validate
    end
        
    def is_public?
      is_public ? true : false
    end
    
    def participants
      @participants << RaveEmbed.public_address if is_public?
      @participants
    end
    
    def to_html
      html = "<script type='text/javascript'>\nfunction #{function_name}() {\n"
      html << "  var wavePanel = new WavePanel('#{root_url}');\n"
      html << "  wavePanel.loadWave('#{wave_id}');\n"
      html << ui_options_js if ui_configured?
      html << "  wavePanel.init(document.getElementById('#{dom_id}'));\n"
      html << "};\n"
      html << "$(#{function_name}())\n" # This line requires jQuery. It simply calls the function_name function once the DOM has loaded.
      html << "</script>\n"
    end
    
  private
  
    def validate
      raise WavePanelError, "Wave ID required to initialize Wave Panel" if wave_id.nil? or wave_id.empty?
    end
    
    def font_size_string
      font_size ? "#{ font_size.to_s }pts" : nil
    end
    
    def ui_configured?
      bg_color or color or font or font_size
    end
    
    def ui_options_js
      if ui_configured?
        ui_options = [bg_color, color, font, font_size_string]
        ui_options = ui_options.collect { |o| "'#{o}'" }
        ui_options_js = "  wavePanel.setUIConfig(#{ ui_options.join(', ') });\n"
      else
        nil
      end
    end
    
  end
  
  class WavePanelError < Exception; end
end