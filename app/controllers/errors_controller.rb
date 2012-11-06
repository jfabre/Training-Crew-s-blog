class ErrorsController < ApplicationController
  include  Trackman::Scaffold::ContentSaver
  after_filter :save_content if Rails.env.development?
  layout 'master'
  # ContentSaver defines two class methods for filtering the ouput of your pages
  #
  # Note that it uses nokogiri to parse the output.
  # You can call the methods multiples times if you need, it will stack the calls.
  
  # edit selector, &block 
  # pass a css or xpath selector and a block that will get executed for each result 
  
  # ie:
  # edit "//link[contains(@src 'http://127.0.0.1:3000'))", do |node|
  #   node['src'] = "http://www.production.com"
  # end

  # remove selector, [optional]&predicate
  # pass a css or xpath selector. You can also pass an optional predicate 
  # to refine the scan instead of trying to make the perfect selector.
  
  # ie:
  # remove 'script', do |node|
  #   node['src'].include? '/assets' && !node['src'].include? 'application'
  # end
  
  
# Don't forget to add the routes in config/routes.rb
# ------
# map.not_found '/404', :controller => 'errors', :action => :not_found
# map.error '/500', :controller => 'errors', :action => :error
# map.maintenance '/maintenance', :controller => 'errors', :action => :maintenance
# map.maintenance_error '/maintenance-error', :controller => 'errors', :action => :maintenance_error
# ------



  def not_found
  end

  def error
  end
  
  def maintenance
  end
  
  def maintenance_error
  end
end
