class Comment < ActiveRecord::Base
  xss_terminate
  belongs_to :post
  default_scope :order => 'created_at DESC'

  validates_presence_of [:user, :text]
  validates_format_of [:user, :text], :with => /[^ ]+/, :on => :create
  
  def replies
    Comment.all(:conditions => {:reply_to => id}, :order => 'created_at ASC')
  end
  def is_root?
    !reply_to || reply_to == 0
  end
  
  def add_reply(user, text)
    reply = Comment.new(:user => user, :text => text, :reply_to => id)
    post.comments << reply
    reply
  end
  
  def is_evil 
    user.nil? || user.strip == '' || text.nil? || text.strip == '' || text.include?('<a href')
  end
  
  def self.cleanup
    Comment.all.each do |c|
      if c.is_evil
        c.replies.each do |r|
          r.destroy
          puts " ----- found reply id: #{r.id} to comment id:#{c.id}  user:#{r.user} text:#{r.text}" 
        end
        puts "found comment id: #{c.id} user:#{c.user} text:#{c.text}" 
        c.destroy
      end
    end
  end
end
