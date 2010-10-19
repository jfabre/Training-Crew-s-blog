class AddReplyToToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :reply_to, :int
  end

  def self.down
    remove_column :comments, :reply_to
  end
end
