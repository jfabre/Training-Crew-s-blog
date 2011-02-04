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
    format read_attribute(:text)
  end
  def format comment
    if comment
      comment = format_carriage_return comment
      comment = format_links comment
    end  
    comment
  end
  def format_carriage_return comment
      comment = comment.gsub(/(\r\n|\n)/, '<br />')
      comment.gsub(/(<br \/>){3,20}/, '<br />')
  end
  def format_links comment
    regex = /[a-zA-Z0-9\-\.]+\.(com|org|net|mil|edu|ca|COM|ORG|NET|MIL|EDU|CA)[A-Za-z0-9\-\.\+\_\/\%\?\#\&\=]*/
    comment = comment.gsub(/http:\/\//, '')
    comment.gsub(regex, '<a target="blank" href="http://\0">\0</a>')
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
