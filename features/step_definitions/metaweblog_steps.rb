require 'meta_weblog_service'
require 'meta_weblog_client'

api=MetaWeblogService.new
client=MetaWebLogClient.new "http://localhost:3000/xmlrpc/api","1","admin","password"

Then /^I should not be able to login as "([^\"]*)" with password "([^\"]*)"$/ do |arg1, arg2|
    begin
      !api.authenticate(arg1,arg2)
    rescue
      true
    end
end

But /^I should be able to login as "([^\"]*)" with password "([^\"]*)"$/ do |arg1, arg2|
  api.authenticate(arg1,arg2)
end

And /([0-9]+) posts should be returned by metaweblogservice$/ do |count|
  posts=api.getRecentPosts(1,"admin","secret",count)
  posts.size.should==count.to_i
end
Then /^a post with slug "([^\"]*)" should exist$/ do |arg1|
  assert_not_nil Post.find_by_slug(arg1)
end
Then /^1 post should be returned by getPost with "([^\"]*)"$/ do |slug|
  api.getPost(slug, "admin","secret")
end

Then /^the post with slug "([^\"]*)" should not be published$/ do |arg1|
  post=Post.find_by_slug(arg1)
  assert post

  assert_equal false, post.is_published
end
Given /^a post exists with slug: "([^\"]*)"$/ do |arg1|
  Post.find_by_slug(arg1)
end

Given /^I call newPost with "([^\"]*)", body "([^\"]*)", categories "([^\"]*)" and "([^\"]*)"$/ do |title, body, cat1, cat2|

  article={
    :title=>title,
    :description=>body,
    :mt_text_more=>body,
    :pubDate=>Time.now,
    :categories=>[cat1,cat2]
  }
  api.newPost(1,"admin","secret",article,1)
end
Given /^I call newPost with "([^\"]*)", body "([^\"]*)", published set to false$/ do |title, body|
  article={
    :title=>title,
    :description=>body,
    :mt_text_more=>body,
    :pubDate=>Time.now,
  }
  api.newPost(1,"admin","secret",article,0)
end
Given /^I call newPost with "([^\"]*)", body "([^\"]*)", categories "([^\"]*)" and "([^\"]*)", published 2 days from now$/ do |title, body, cat1, cat2|
  article={
    :title=>title,
    :description=>body,
    :mt_text_more=>body,
    :pubDate=> Time.now.advance(:day => 2),
    :categories=>[cat1,cat2]
  }
  api.newPost(1,"admin","secret",article,0)
  
end

And /^the post with slug "([^\"]*)" should belong to categories "([^\"]*)" and "([^\"]*)"$/ do |slug, cat1, cat2|
 post = Post.find_by_slug(slug)
 
 #cats = post.categories.all()
 
 #cats.each {|x| assert x.title == cat1 || x.title == cat2 }
 assert post.categories.titled(cat1)
 assert post.categories.titled(cat2)
end
And /^categories "([^\"]*)" and "([^\"]*)" should have post with slug "([^\"]*)"$/ do |arg1, arg2, arg3|
  cat = Category.titled(arg1).first
  
  assert_not_nil cat.posts.first
  cat = Category.titled(arg2).first
  assert_not_nil cat.posts.first

end
When /^I call editPost with slug "([^\"]*)" and change the title to "([^\"]*)" and body to "([^\"]*)"$/ do |slug, title, body|
   
   id=Post.find_by_slug(slug).id
   
   article=api.getPost(id, "admin","secret")
   
   hash={
     :title=>title,
     :description=>body,
     :mt_text_more=>body,
     :wp_slug=>slug,
     :pubDate=>Time.gm(Time.now.year+1,"01","01"),
   }
   api.editPost(slug,"admin","secret",hash,1)
end

When /^I call editPost with slug "([^\"]*)" and set published to false$/ do |slug|
  id=Post.find_by_slug(slug).id
  article=api.getPost(id, "admin","secret")
  hash={
    :title=>article.title,
    :description=>"nada",
    :mt_text_more=>"nada",
    :wp_slug=>article.wp_slug,
    :pubDate=>Time.gm(Time.now.year+1,"01","01"),
  }
  
  
  api.editPost(slug,"admin","secret",hash,0)
end
When /^I call editPost with slug "([^\"]*)" and set published_at to "([^\"]*)"$/ do |slug, pub|
  id=Post.find_by_slug(slug).id
  article=api.getPost(id, "admin","secret")
  article.pubDate=pub
  
  api.editPost(slug,"admin","secret",article, 0)
end
Then /^I should have 2 categories when calling getCategories with api$/ do
  cats=api.getCategories(1,"admin","secret")
  cats.size.should==2
end

When /^I upload a file using the api$/ do
  file_path="#{RAILS_ROOT}/log/development.log"
  bits=File.open(file_path, "r")
  media=MediaObject.new
  media.name=file_path
  media.bits=bits
  uploaded=api.newMediaObject(1,"admin","secret",media)
  
  assert_equal "#{Blog.url}/system/uploads/development.log", uploaded.url
end

Then /^that file should exist in public uploads$/ do
  expected_path="#{RAILS_ROOT}/public/system/uploads/development.log"
  assert File.file?(expected_path)
end

Then /^the post with slug "([^\"]*)" should have ([0-9]+) comments$/ do |arg1,num|
  post=Post.find_by_slug(arg1)
  assert_equal num.to_i,post.comments.count
end
Then /^I should have ([0-9]+) categories with getCategories$/ do |num|
  cats=api.getCategories("1","admin","secret")
  #raise cats.inspect
  assert_equal num.to_i, cats.size
end


Given /^the database is empty$/ do
  #has nothing to do?
end