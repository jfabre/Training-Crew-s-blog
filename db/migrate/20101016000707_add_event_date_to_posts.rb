class AddEventDateToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :event_date, :datetime
  end

  def self.down
    remove_column :posts, :event_date
  end
end
