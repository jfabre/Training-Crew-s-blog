class ChangeDefaultIsPublishedToFalse < ActiveRecord::Migration
  def self.up
    change_column :posts, :is_published, :boolean, :default => false
  end

  def self.down
    change_column :posts, :is_published, :boolean
  end
end
