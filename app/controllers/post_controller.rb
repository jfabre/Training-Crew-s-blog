class PostController < ApplicationController
  layout 'master'
  
  def index
    @category = Category.find_by_slug(params[:slug])
    @posts = @category.posts unless @category.nil?
  end
  
  def rss  
    @posts=Post.recent_sorted(10)
  end
  
  def show
    @post= Post.find_by_slug(params[:slug])
    render '404' if @post.nil?
  end
  
  def publications
    @posts = Post.all(:order => "published_at DESC")
  end
end