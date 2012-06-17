class AddHeightAndWidthToImages < ActiveRecord::Migration
   def self.up
    add_column :images, :height, :integer, :null => false, :default => 600
    add_column :images, :width, :integer, :null => false, :default => 800
  end

  def self.down
    remove_column :images, :width, :integer
    remove_column :images, :width, :integer
  end
end
