class CommentController < ApplicationController
  before_filter :setup_negative_captcha
  
  def new
    puts "GOT HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    @post = Post.find(params[:id])

    @name = cookies['poster'] || "Nom"
  end
  def reply
    @comment = Comment.find(params[:id])
    @name = cookies['poster'] || "Nom"
  end

  def add_comment
    post = Post.find(params[:id])
    if @captcha.valid?
      comment = Comment.new(:user => @captcha.values[:name], :text => @captcha.values[:text], :ip_address => request.remote_ip)
      post.comments << comment
      post.save!
      cookies['poster'] = { :value => comment.user, :expires => 1.year.from_now }
    end
    redirect_to :action => 'new', :slug => post.slug
  end

  def add_reply 
   root_comment = Comment.find(params[:id]);
   if @captcha.valid?
    reply = root_comment.add_reply(@captcha.values[:name], @captcha.values[:text], request.remote_ip)
    root_comment.post.save!
    cookies['poster'] = { :value => reply.user, :expires => 1.year.from_now }
   end
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