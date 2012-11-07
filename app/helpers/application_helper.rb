# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def format_comment comment
    if comment
      format_links comment
      format_images comment
      format_youtube comment
      format_carriage_return comment
    end  
    comment
  end
  def format_carriage_return comment
      comment.gsub!(/(\r\n|\n)/, '<br />')
      comment.gsub!(/(<br \/>){3,20}/, '<br />')
  end
  def format_links comment
    @@link ||= /(https?:\/\/)?(([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,3}[A-Za-z0-9\-\.\+\_\/\%\?\#\&\=]*)/
    comment.gsub!(@@link, '<a target="blank" href="\1\2">\2</a>')
    comment.gsub!(/<a target="blank" href="([^h][^t]{2}[^p].+)"/, '<a target="blank" href="http://\1"')
  end
  def format_images comment
    @@img ||= /<a target="blank" href="(.+(png|jpeg|jpg|gif))">.+<\/a>/
    comment.gsub!(@@img, '<img src="\1" />')
  end
  def format_youtube comment
    @@youtube ||= /<a target="blank" href="https?:\/\/www.youtube.com\/watch\?.*v=([^\&]+).*">.+<\/a>/
    comment.gsub!(@@youtube, '<iframe width="560" height="315" src="http://www.youtube.com/embed/\1" frameborder="0" allowfullscreen></iframe>')
  end
  
  def friendly_display date
    hours,minutes,seconds = Date.day_fraction_to_time(DateTime.now - date.to_datetime)
    
    if hours > 7 * 24
      return date.strftime("%Y-%m-%d")
    elsif (24..(24 * 7)).include?(hours)
        return "Depuis #{pluralize(hours / 24, 'jour')}"
    elsif (1..23).include?(hours)
      return "Depuis #{pluralize(hours, 'heure')}"
    elsif (1..59).include?(minutes)
      return "Depuis #{pluralize(minutes, 'minute')}"
    end 
    return "Depuis #{pluralize(seconds, 'seconde')}"
  end
end
