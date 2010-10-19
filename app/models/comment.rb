class Comment < ActiveRecord::Base
  belongs_to :post
  
  def replies
    Comment.all(:conditions => {:reply_to => id})
  end
  def is_root?
    !reply_to || reply_to == 0
  end
end
