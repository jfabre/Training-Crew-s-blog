class Blog
  def self.title
    "Training crew's blog"
  end
  
  def self.tagline
    "Parkour shizzles"
  end

  def self.author
    "Jeremy Fabre"
  end
  
  def self.url
    domain = "http://127.0.0.1:3000" 
    domain = ENV['domain'] = unless ENV['domain'].nil? 
    domain
  end 
end