class RemoveIsPublishedFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :is_published
  end

  def self.down
    add_column :posts, :is_published, :boolean, :default => false
  end
end
