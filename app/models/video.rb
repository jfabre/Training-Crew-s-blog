class Video < ActiveRecord::Base
  def small_embed
    result = ''
    if embed
      result = embed.gsub(/width="[^"]+" height="[^"]+"/, "height=\"240\" width=\"240\"")
    end
    result
  end
end
