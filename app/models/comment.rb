class Comment < ActiveRecord::Base
  xss_terminate
  belongs_to :post
  default_scope :order => 'created_at DESC'

  validates_presence_of [:user, :text]
  validates_format_of [:user, :text], :with => /[^ ]+/, :on => :create
  
  def validate
    errors.add_to_base "is evil" if evil?
    #errors.add_to_base "is too old" if Date.today - post.created_at.to_date > 30
  end
  
  def replies
    Comment.all(:conditions => {:reply_to => id}, :order => 'created_at ASC')
  end
  def is_root?
    !reply_to || reply_to == 0
  end
  
  def add_reply(user, text, ip_address)
    reply = Comment.new(:user => user, :text => text, :reply_to => id, :ip_address => ip_address)
    post.comments << reply
    reply
  end
  
  def evil? 
    user.nil? || user.strip == '' || text.nil? || text.strip == '' || text.include?('<a href') || text.scan(/http/).size > 4 
  end
  
  def suspicious?
    user !~ /(Jeremy|Justin|MeCarana|Tchad|Tit-gars)/ && text.include?('http')  
  end
  def self.trolls_today
    Comment.all(:conditions => ["created_at > ?", Date.today]).select{|c| c.troll? }
  end

  def troll?
    user.downcase == 'mecarana'
  end
  def self.cleanup(comments = nil)
    comments.each do |c|
      c.replies.each do |r|
        r.destroy
        puts " Deleting reply id: #{r.id} to comment id:#{c.id}  user:#{r.user} text:#{r.text}" 
      end
      puts "Deleting comment id: #{c.id} user:#{c.user} text:#{c.text}" 
      c.destroy
    end
  end
end
