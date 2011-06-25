class Comment < ActiveRecord::Base
  belongs_to :post
  default_scope :order => 'created_at DESC'

  def replies
    Comment.all(:conditions => {:reply_to => id}, :order => 'created_at ASC')
  end
  def is_root?
    !reply_to || reply_to == 0
  end
  
  def since
    created_at = read_attribute(:created_at).to_datetime
    hours,minutes,seconds = Date.day_fraction_to_time(DateTime.now - created_at)
    
    if hours > 7 * 24
      return created_at.strftime("%Y-%m-%d")
    elsif block_given?
      return yield hours, minutes, seconds
    else
      return "#{hours} #{minutes} #{seconds}"
    end
  end
end
