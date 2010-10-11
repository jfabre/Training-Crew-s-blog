class PostController < ApplicationController
  def index
    @categories=Category.all
    slug=params[:slug]
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
    render "404" unless @post
  end
  
  def add_comment
    puts "In Add Comment"
    post = Post.find(params[:id]);
    comment = Comment.create!(:user => params[:name], :text => params[:comment])
    
    post.comments << comment
    post.save
    
    puts "slug = #{post.slug}"
    
    
    redirect_to :action => 'show', :slug => post.slug, :year =>  post.year, :month => post.month , :day => post.day
  end
    
end