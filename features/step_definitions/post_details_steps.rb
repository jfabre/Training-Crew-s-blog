
Given /^the following comments exist for a post with title "([^"]*)"$/ do |arg1, table|
  post=Post.find_by_title(arg1)
  
  table.hashes.each do |hash|
    post.comments << Comment.new(hash) 
  end

  assert_equal 4, post.comments.size
  post.save
  
  post=Post.find_by_title(arg1)
  assert_equal 4, post.comments.size
end
Then /^the post with title "([^\"]*)" should have ([0-9]+) comments$/ do |arg1, num|
  post= Post.find_by_title(arg1)
  assert_equal num.to_i, post.comments.size
end

Then /^the post with title "([^"]*)" should have url "([^"]*)"$/ do |title, url|
  post = Post.find_by_title(title)
  assert_equal url, post.url 
end