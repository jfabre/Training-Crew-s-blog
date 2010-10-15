# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

User.create( :username => 'admin', :password => 'pk' ) unless User.find_by_username('admin')
      
Post.create( :title => 'Title test', :slug => 'title_test', 
                :body => 'First post!', :published_at => DateTime.now ) unless Post.find(1)
