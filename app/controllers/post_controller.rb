class PostController < ApplicationController
  layout 'master'
  
  def index
    @category = Category.find_by_slug!(params[:slug])
    
    @posts = @category.posts
    @posts = @posts.all(:conditions => {:is_published => true}, :order => 'published_at DESC')
    @posts = @posts.paginate(:page => params[:page], :per_page => 5) 
  
  end
  
  def rss  
    @posts=Post.recent_sorted(10)
  end
  
  def show
    @post= Post.find_by_slug!(params[:slug], :conditions => {:is_published => true}, :order => 'published_at DESC')
  end
  
  def publications
    @posts = Post.all(:order => 'published_at DESC')
  end
  
  def publish
    to_publish = []  
    
    Post.transaction do
      ids = []
      ids = params[:to_publish].collect{|x| Integer(x)} unless params[:to_publish].nil?
      to_publish = Post.all(:conditions => { :id => ids})
      
      to_unpublish = Post.all.select{|x| !ids.include?(x.id) }
      
      to_publish.each do |p|
        p.is_published = true
        p.save!
      end
      to_unpublish.each do |p|
        p.is_published = false
        p.save!
      end
    end
    redirect_to(:action => :publications, :notice => 'Yay!') 
  end  
end