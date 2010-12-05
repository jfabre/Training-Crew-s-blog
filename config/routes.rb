ActionController::Routing::Routes.draw do |map|
  
  map.tchad '/tchad', :controller => :home, :action => :tchad
  map.resources :images
  map.albums 'albums/:action/:id', :controller => :albums
  map.display_album 'albums/display/:id', :controller => :albums, :action => :display
  
  map.list_videos '/videos/list', :controller => 'videos', :action => 'list'
  map.resources :videos
  map.connect '/contact', :controller => 'home', :action => 'contact'
  map.resume '/resume', :controller => 'home', :action => 'resume'
  
  map.connect 'xmlrpc/api', :controller => "xmlrpc", :action=> "api"
  map.wp_post ':year/:month/:day/:slug', :controller => 'post', :action=> 'show'
  map.new_comment '/:slug/comment/new', :controller => 'comment', :action => 'new'
  
  map.category 'category/:slug', :controller => 'post', :action=> 'index'
  map.post_by_category  ':category_slug/:slug', :controller => 'post', :action=> 'show'
  map.search 'search', :controller=> 'post', :action=>'search'
  map.category ':slug', :controller => 'post', :action=> 'index'
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
