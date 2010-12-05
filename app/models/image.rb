class Image < ActiveRecord::Base
  include Amazon_image
  belongs_to :album
  
  named_scope :in_albums, (lambda do  {:conditions => "album_id IS NOT NULL"} end)
end
