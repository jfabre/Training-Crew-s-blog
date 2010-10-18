class Video < ActiveRecord::Base
  def youtube
    embed.gsub(/width="[^"]+" height="[^"]+"/, "height=\"240\" width=\"240\"")
  end
end
