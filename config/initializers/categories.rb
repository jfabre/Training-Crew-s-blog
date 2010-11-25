if Category.all().empty?
  to_create = ["Entrainements", "Activités"]
  
  to_create.each do |title|
    Category.create!(:title => title, :slug => Post.create_slug(title))
  end
end
