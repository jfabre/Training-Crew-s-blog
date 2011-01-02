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
    friendly_display(hours, minutes, seconds)
  end
  
  def friendly_display hours, minutes, seconds
    if hours > 7 * 24
      return created_at.strftime("%Y-%m-%d")
    elsif (24..(24 * 7)).include?(hours)
      if (24..47).include?(hours)
        return "Depuis une journée"
      else  
        return "Depuis #{hours / 24} jours"
      end
    elsif (2..23).include?(hours)
      return "Depuis #{hours} heures"
    elsif hours == 1
      return "Depuis une heure"
    elsif (2..59).include?(minutes)
      return "Depuis #{minutes} minutes"
    elsif minutes == 1
      return "Depuis une minute"
    end 
    return "Depuis #{seconds} secondes"
  end
end
