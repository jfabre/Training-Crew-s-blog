begin 
  Comment.transaction do
    comment = Comment.find(461) #|| Comment.find(:all, :conditions => "user LIKE '%Nom%'")
    comment.delete unless comment.nil?
    #puts comment.inspect
    #comments.each{|c|  }
    #comments.each{|c| c.delete }
  end
rescue
end
