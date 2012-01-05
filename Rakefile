# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'


desc 'cleanup evil comments'
task :cleanup_evil => :environment do
  Comment.cleanup Comment.all.select{|x| x.evil? }
end

task :cleanup_suspicious => :environment do
  comments = Comment.all.select{ |x|  x.suspicious? }
  response = 'n'
  
  evils = comments.select do |c|
    unless response == 'p'
      print "\n\n-------------------------------------------------"
      print "\nId:#{c.id} user: #{c.user}" 
      print "\nText: #{c.text}"
      print "\n\nIs it evil? (y/n): "
      response = STDIN.gets.chomp
    end
    response == 'y'
  end
  Comment.cleanup evils
end



