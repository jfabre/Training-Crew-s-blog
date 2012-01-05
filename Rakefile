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
  Comment.cleanup evil_from_suspicious
end

task :show_suspicious => :environment do
  evils = evil_from_suspicious
  puts evils.map{ |c| c.id }.join(';')
end

task :clean_specifics, [:ids] => :environment do |t, args|
  ids = args[:ids].split(';').map{|x| x.to_i }
  comments = Comment.all(:conditions => {:id => ids })
  
  Comment.cleanup comments
end

task :clean_heroku => :environment do
  ids = ENV['cleanup'].split(';').map{|x| x.to_i }

  Comment.cleanup Comment.all(:conditions => {:id => ids })
end
def evil_from_suspicious
  comments = Comment.all.select{ |x|  x.suspicious? }
  response = 'n'
  
  comments.select do |c|
    unless response == 'p'
      print "\n\n-------------------------------------------------"
      print "\nId:#{c.id} user: #{c.user}" 
      print "\nText: #{c.text}"
      print "\n\nIs it evil? (y/n): "
      response = STDIN.gets.chomp
    end
    response == 'y'
  end
end