class Category < ActiveRecord::Base
    has_many :categorizations
    has_many :posts, :through => :categorizations
    named_scope :titled, (lambda do |title| 
      {:conditions => ['title = ?', title]}
    end)


    def self.clear_posts(post)
      Category.all().each {|c| c.articles.delete(post.slug)}
    end
    
    def clear_posts
      :articles.clear
    end
    
    def self.categorize(name, post)
      by_title_or_slug = { :title  => name, :slug => name }
      
      if(!Category.exists?(by_title_or_slug))
        existing_category = Category.create!(:title=> name, :slug=> Post.create_slug(name))
      else
        existing_category = Category.find(:conditions => by_title_or_slug)
      end
      
      #associate them   
      post.categories << existing_category
      existing_category.posts << post
       
      post.save
      existing_category.save
    end
end
