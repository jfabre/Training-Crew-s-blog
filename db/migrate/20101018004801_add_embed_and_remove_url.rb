class AddEmbedAndRemoveUrl < ActiveRecord::Migration
  def self.up
    add_column :videos, :embed, :text
    remove_column :videos, :url
  end

  def self.down
    add_column :videos, :url, :string
    remove_column :videos, :embed
  end
end
