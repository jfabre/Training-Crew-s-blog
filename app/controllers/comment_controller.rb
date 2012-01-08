class CommentController < ApplicationController
  before_filter :setup_negative_captcha
  
  def new
    @post = Post.find_by_slug(params[:slug])
    @name = cookies['poster']
    @name = "Nom" if @name.nil?
    
    render '404' unless @post
  end
  def reply
    @comment = Comment.find(params[:id])
    @name = cookies['poster']
    @name = "Nom" if @name.nil?
  end
  def add_comment
    raise 'Invalid comment' unless @captcha.valid?
    post = Post.find(params[:id])
    comment = Comment.new(:user => @captcha.values[:name], :text => @captcha.values[:text])
    post.comments << comment
    post.save
    
    cookies['poster'] = { :value => comment.user, :expires => 1.year.from_now }
    redirect_to :action => 'new', :slug => post.slug
  end
  def add_reply
    raise 'Invalid comment' unless @captcha.valid?
    
    root_comment = Comment.find(params[:id]);
    reply = root_comment.add_reply(@captcha.values[:name], @captcha.values[:text])
    root_comment.post.save
    
    cookies['poster'] = { :value => reply.user, :expires => 1.year.from_now }
    redirect_to :action => 'new', :slug => root_comment.post.slug
  end  
  
  private
    def setup_negative_captcha
      @captcha = NegativeCaptcha.new(
        :secret => 'alllo super secret', #A secret key entered in environment.rb.  'rake secret' will give you a good one.
        :spinner => request.remote_ip, 
        :fields => [:name, :text], #Whatever fields are in your form 
        :params => params)
    end
end