module RaveEmbed
  class RaveEmbed::WavePanelError < Exception; end
  
  class WavePanel
    include ClassLevelInheritableAttributes
    
    cattr_inheritable   :g_public_address, :g_root_url, :g_dom_id, :g_bg_color, :g_color, :g_font, 
                        :g_font_size, :g_is_public, :g_embed_js_url, :g_height, :g_width, :g_jquery
    @g_public_address      = 'public@a.gwave.com'
    @g_root_url            = 'https://wave.google.com/a/wavesandbox.com/'
    @g_dom_id              = 'waveframe'
    @g_is_public           = true
    @g_height              = '100%'
    @g_width               = '100%'
    @g_jquery              = false
    

    attr_accessor :wave_id, :dom_id, :root_url, :bg_color, :color, :font, :font_size, 
                  :participants, :is_public, :height, :width, :jquery
  
    def initialize(wave_id_str, opts = {})
      @wave_id       = wave_id_str
      @dom_id        = opts[:dom_id]        || WavePanel.g_dom_id
      @root_url      = opts[:root_url]      || WavePanel.g_root_url
      @bg_color      = opts[:bg_color]      || WavePanel.g_bg_color
      @color         = opts[:color]         || WavePanel.g_color
      @font          = opts[:font]          || WavePanel.g_font
      @font_size     = opts[:font_size]     || WavePanel.g_font_size
      @height        = opts[:height]        || WavePanel.g_height
      @width         = opts[:width]         || WavePanel.g_width
      @jquery        = opts[:jquery]        || WavePanel.g_jquery
      @is_public = if opts[:is_public].nil?
        WavePanel.g_is_public
      else
        opts[:is_public] ? true : false
      end
      @participants  = opts[:participants]  || []
      validate
    end
    
    def wave_id=(wave_id_str)
      @wave_id = wave_id_str
      validate
    end
            
    def participants
      @participants << WavePanel.g_public_address if is_public?
      @participants
    end
    
    def to_html
      html = "<div id='#{dom_id}'"
      html << " width='#{width}'" unless width.nil? or width.empty?
      html << " height='#{height}'" unless height.nil? or height.empty?
      html << "></div>\n"
      html << "<script type='text/javascript'>\n"
      html << "$(document).ready({\n" if jquery?
      html << "  var wavePanel = new WavePanel('#{root_url}');\n"
      html << "  wavePanel.loadWave('#{wave_id}');\n"
      html << ui_options_js if ui_configured?
      html << "  wavePanel.init(document.getElementById('#{dom_id}'));\n"
      html << "})\n" if jquery?
      html << "</script>\n"
    end
    
  private
  
    def validate
      raise WavePanelError, "Wave ID required to initialize Wave Panel" if wave_id.nil? or wave_id.empty?
    end
    
    def ui_configured?
      bg_color or color or font or font_size
    end
    
    def is_public?
      is_public ? true : false
    end
    
    def jquery?
      jquery ? true : false
    end
    
    def ui_options_js
      if ui_configured?
        ui_options = [bg_color, color, font, font_size]
        ui_options = ui_options.collect { |o| "'#{o}'" }
        ui_options_js = "  wavePanel.setUIConfig(#{ ui_options.join(', ') });\n"
      else
        nil
      end
    end
    
  end
  
end