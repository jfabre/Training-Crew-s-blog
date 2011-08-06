begin 
  Comment.transaction do
    comments = Comment.find_by_user('Nom')
    comments.each{|c| c.delete }
  end
rescue
end
