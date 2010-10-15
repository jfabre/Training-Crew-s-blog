class Post < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, :through => :categorizations
  has_many :comments
  
  def pretty_date
    published_at.strftime("%A, %B %d, %Y")
  end
  
  def self.by_category(slug, limit)
    Category.find_by_slug(slug).posts
  end
  def clear_categories
    categorizations.clear
  end
  def self.recent_sorted(limit)
     Post.all(:order=>"published_at DESC", :limit=>limit, :is_published=>true)
  end
  def self.create_slug(str)
    #a slug is a URL-safe string that echoes the title
    #in this method we want to remove any weird punctuation and spaces
    if (str)
      str = str.gsub(/[^a-zA-Z0-9 ]/,"").downcase
      str = str.gsub(/[ ]+/," ")
      str = str.gsub(/ /,"_")
    end
    str
  end
  
  def year
    published_at.year.to_s if(published_at)
  end
  def month
    sprintf("%.2d",published_at.month) if(published_at)   
  end
  def day
    sprintf("%.2d",published_at.day) if(published_at)
  end
  def url
    "/#{year}/#{month}/#{day}/#{slug}"
  end
end
