class RemoveEventToPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :event_date
  end

  def self.down
    add_column :posts, :event_date, :datetime
  end
end
