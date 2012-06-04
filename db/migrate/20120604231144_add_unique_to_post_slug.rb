class AddUniqueToPostSlug < ActiveRecord::Migration
  def self.up
    # 53 -> 66

    to_transfer = Comment.all(:conditions => {:id => [1143, 1144, 1145]})
    to_delete = Comment.all(:conditions => {:id => [1142, 1146, 1147, 1148] })

    to_transfer.each{|c| c.post_id = 66; c.save! }
    to_delete.each{|c| c.destroy }    
    add_index :posts, [:published_at, :slug], :unique => true
  end

  def self.down
    remove_index :posts, :published_at
  end
end
