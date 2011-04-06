class Category < ActiveRecord::Base
    has_many :categorizations
    has_many :posts, :through => :categorizations
    scope :titled, (lambda do |title| {:conditions => ['title = ?', title]} end)


    def self.clear_posts(post)
      Category.all().each do |c| 
         c.posts.delete(post)
      end
    end
    
    def self.categorize(name, post)
      cat = Category.find_by_slug(Post.create_slug(name))
      raise "could not find the category #{Post.create_slug(name)}" if cat.nil?
       
      cat.posts << post
      cat.save
    end
end
