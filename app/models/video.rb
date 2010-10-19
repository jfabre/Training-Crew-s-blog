class Video < ActiveRecord::Base
  def small_embed
    embed.gsub(/width="[^"]+" height="[^"]+"/, "height=\"240\" width=\"240\"")
  end
end
