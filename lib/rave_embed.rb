class RaveEmbed
  cattr_accessor :public_address, :root_url, :function_name, :dom_id, 
                 :bg_color, :color, :font, :font_size, :is_public, :embed_js_url
  public_address = "public@a.gwave.com"
  root_url = "https://wave.google.com/a/wavesandbox.com/"
  function_name = 'wavePanelInit'
  dom_id = 'waveframe'
  is_public = true
  embed_js_url = 'http://wave-api.appspot.com/public/embed.js'
end