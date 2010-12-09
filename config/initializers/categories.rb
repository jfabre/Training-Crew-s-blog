# encoding: utf-8
to_create = ['Entrainements', 'Activités']
begin
  if Category.all.size != to_create.size 
    Category.destroy_all
    to_create.each do |title|
      Category.create!(:title => title, :slug => Post.create_slug(title))
    end
  end
rescue
end

begin 
  if User.all.size == 0 
    unless ENV['admin_user'].nil? or ENV['admin_pass'].nil? 
      User.create({:username => ENV['admin_user'] , :password => ENV['admin_pass']}) 
    end
  end
rescue
end