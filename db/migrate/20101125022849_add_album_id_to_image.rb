class AddAlbumIdToImage < ActiveRecord::Migration
   def self.up
    add_column :images, :album_id, :integer
  end

  def self.down
    remove_column :images, :album_id
  end
end
