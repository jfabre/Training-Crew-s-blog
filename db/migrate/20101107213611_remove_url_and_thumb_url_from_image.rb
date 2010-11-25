class RemoveUrlAndThumbUrlFromImage < ActiveRecord::Migration
  def self.up
    remove_column :images, :url
    remove_column :images, :thumb_url
  end

  def self.down
    add_column :images, :thumb_url, :string
    add_column :images, :url, :string
  end
end
