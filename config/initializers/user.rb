begin 
  unless ENV['admin_user'].nil? or ENV['admin_pass'].nil? 
    username = ENV['admin_user']
    pass = ENV['admin_pass']
    
    User.delete_all if User.find_by_username_and_password(username, pass).nil?
    User.create({:username => username , :password => pass}) if User.all.empty? 
  end
rescue
end