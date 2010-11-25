class AddTitleAndDescriptionToImage < ActiveRecord::Migration
  def self.up
    add_column :images, :title, :string
    add_column :images, :description, :string
  end

  def self.down
    remove_column :images, :description
    remove_column :images, :title
  end
end
