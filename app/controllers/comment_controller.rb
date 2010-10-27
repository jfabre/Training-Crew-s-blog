class CommentController < ApplicationController
  def add_comment
    post = Post.find(params[:id]);
    comment = Comment.create!(:user => params[:name], :text => params[:comment])
    
    post.comments << comment
    post.save
    
    redirect_to :action => 'new', :slug => post.slug
  end
  def new
    @post = Post.find_by_slug(params[:slug])
    render '404' unless @post
  end
  def reply
    @comment = Comment.find(params[:id])
  end
  def add_reply
    root_comment = Comment.find(params[:id]);
    reply = Comment.create!(:user => params[:name], :text => params[:comment], :reply_to => root_comment.id)
    post = root_comment.post
    post.comments << reply
    post.save
    redirect_to :action => 'new', :slug => post.slug
  end  
end