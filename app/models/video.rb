class Video < ActiveRecord::Base
  @@handlers = /^embed_[0-9]{2,4}$/
  def small_embed
    embed_at_size(240)
  end
  def self.method_missing(method_sym, *arguments, &block)
    if method_sym.to_s =~ @@handlers 
      embed_at_size(method_sym.to_s.delete('embed_'))
      super
    else
      super
    end
  end
  def self.respond_to?(method_sym, include_private = false)
    if method_sym.to_s =~ @@handlers
      true
    else
      super
    end
  end
  
  def embed_at_size(height, width = height)
    result = ''
    if embed
      result = embed.gsub(/width="[^"]+" height="[^"]+"/, "height=\"#{height}\" width=\"#{width}\"")
    end
    result
  end
end
