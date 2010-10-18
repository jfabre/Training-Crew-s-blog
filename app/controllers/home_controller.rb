class HomeController < ApplicationController
  layout 'master'
  def index
    @latest_video = Video.all(:order => "created_at DESC").first
    @latest_video = Video.new(:description => 'No video available') unless @latest_video
    @categories = Category.all
    @posts = Post.all(:order => "published_at DESC", :limit => 5)
  end

  def contact
  end

  def resume
  end
end
