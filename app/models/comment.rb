class Comment < ActiveRecord::Base
  belongs_to :post
  default_scope :order => 'created_at DESC'

  def replies
    Comment.all(:conditions => {:reply_to => id}, :order => 'created_at ASC')
  end
  def is_root?
    !reply_to || reply_to == 0
  end
  def text
    val = read_attribute(:text)
    if(val)
      val = val.gsub('\r\n', '<br />')
      val = val.gsub('http://', '')
      val = val.gsub(/[^ ][a-zA-Z0-9\-\.]+\.(com|org|net|mil|edu|ca|COM|ORG|NET|MIL|EDU|CA)/, '<a target="blank" href="http://\0">\0</a>')
    end  
    val
  end
end
