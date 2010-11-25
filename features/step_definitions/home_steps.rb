Given /^post "([^\"]*)" is part of category "([^\"]*)"$/ do |post_slug, category_slug|
  post = Post.find_by_slug(post_slug)
  Category.categorize(category_slug, post) 
end