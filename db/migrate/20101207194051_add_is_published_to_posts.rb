class AddIsPublishedToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :is_published, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :posts, :is_published
  end
end
