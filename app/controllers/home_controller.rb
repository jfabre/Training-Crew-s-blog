class HomeController < ApplicationController
  layout 'master'
  def index
    @latest_video = Video.all(:order => "created_at DESC").first
    if(@latest_video.nil?)
      @latest_video = Video.new(:description => 'No video available')
    end
    @latest_pic = Image.in_albums(:order => "created_at DESC").first

    @categories = Category.all
    @posts = Post.all(:conditions => {:is_published => true}, :order => 'published_at DESC').paginate(:page => params[:page], :per_page => 5)
    @title = (@posts.first || Post.new(:title => '')).title
  end

  def contact
  end

  def resume
  end
  
  def tchad 
  end
end
