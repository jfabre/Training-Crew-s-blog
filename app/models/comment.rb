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
      val = val.gsub(/(\r\n|\n)/, '<br />')
      val = val.gsub(/(<br \/>){3,20}/, '<br />')
      val = val.gsub(/http:\/\//, '')
      val = val.gsub(/[^ ][a-zA-Z0-9\-\.]+\.(com|org|net|mil|edu|ca|COM|ORG|NET|MIL|EDU|CA)/, '<a target="blank" href="http://\0">\0</a>')
    end  
    val
  end
  def since
    created_at = read_attribute(:created_at).to_datetime
    hours,minutes,seconds = Date.day_fraction_to_time(DateTime.now - created_at)
    
    if hours > 7 * 24
      return created_at.strftime("%Y-%m-%d")
    elsif (24..(24 * 7)).include?(hours)
      return "Il y a #{hours / 24} jours"
    elsif (1..23).include?(hours)
      return "Il y a #{hours} heures"
    elsif (1..59).include?(minutes)
      return "Il y a #{minutes} minutes"
    end 
    return "Il y a #{seconds} secondes"
  end
end
