class HomeController < ApplicationController
  def index
    @categories = Category.all
    @posts = Post.all(:order=>"published_at DESC", :limit=>5)
  end

  def contact
  end

  def resume
  end
end
