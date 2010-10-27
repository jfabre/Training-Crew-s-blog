class HomeController < ApplicationController
  layout 'master'
  def index
    @latest_video = Video.all(:order => "created_at DESC").first
    if(!@latest_video)
      @latest_video = Video.new(:description => 'No video available')
    end
    @categories = Category.all
    
    @posts = Post.paginate(:page => params[:page], :order => 'published_at DESC', :per_page => 5)
  end

  def contact
  end

  def resume
  end
end
