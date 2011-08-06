begin 
  Comment.transaction do
    comments = Comment.find(:all, :conditions => "user LIKE '%Nom%'")
    comments.each{|c| c.delete }
  end
rescue
end
