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

