class Category < ActiveRecord::Base
    has_many :categorizations
    has_many :posts, :through => :categorizations
    named_scope :titled, (lambda do |title| {:conditions => ['title = ?', title]} end)


    def self.clear_posts(post)
      Category.all().each do |c| 
         c.posts.delete(post)
      end
    end
    
    def self.categorize(name, post)
      cat = Category.find_by_slug(name)
      cat = Category.create!(:title=> name, :slug=> Post.create_slug(name)) if cat.nil?
      
      post.categories << cat 
      cat.posts << post
       
      post.save
      cat.save
    end
end
