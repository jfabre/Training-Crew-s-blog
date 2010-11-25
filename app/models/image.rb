class Image < ActiveRecord::Base
  include Amazon_image
  belongs_to :album
end
