class CommentController < ApplicationController
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
    post = Post.find(params[:id])
    comment = Comment.create!(:user => params[:name], :text => params[:comment])
    
    post.comments << comment
    post.save
    
    cookies['poster'] = { :value => comment.user, :expires => 1.year.from_now }
    redirect_to :action => 'new', :slug => post.slug
  end
  def add_reply
    root_comment = Comment.find(params[:id]);
    reply = Comment.create!(:user => params[:name], :text => params[:comment], :reply_to => root_comment.id)
    post = root_comment.post
    post.comments << reply
    post.save
    
    cookies['poster'] = { :value => reply.user, :expires => 1.year.from_now }
    redirect_to :action => 'new', :slug => post.slug
  end  
end