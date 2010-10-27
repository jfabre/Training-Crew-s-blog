class PostController < ApplicationController
  layout "master"
  
  def index
    @categories=Category.all
    slug=params[:category_slug]
    if(slug)
      @posts=Post.by_category(slug, 1000)
    else
      @posts=Post.recent_sorted(10)
    end
  end
 
  def rss  
    @posts=Post.recent_sorted(10)
  end
  
  def show
    @post= Post.find_by_slug(params[:slug])
    render '404' unless @post
  end
  
  
end