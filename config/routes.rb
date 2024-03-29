Blog::Application.routes.draw do
  get "post/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

	get "/posts",							 :controller => :post,     :action => :index
	get "/posts/new",						 :controller => :post,	  :action => :new
	get "posts/search",						 :controller => :post,	  :action => :search,			:as => "search"
	post "posts/search/posts",				 :controller => :post,	  :action => :listing,			:as => "listing_research"
	get "/posts/:id", 						 :controller => :post,     :action => :read, 			:as => "consult"
	post "/posts/:id/saveNote",				 :controller => :note,	  :action => :saveNote,			:as => "saveNote"	
	post "/posts", 						 :controller => :post,     :action => :create,			:as => "createPost"	
	delete '/post/delete/:id', 				 :controller => :post,     :action => :destroy, 			:as => "delete"
	post "/posts/:id", 						 :controller => :post,     :action => :accessModify,	 	:as => "accessModify"
	put "/posts/:id",						 :controller => :post,     :action => :modify, 			:as => "modify"

	get "/people",							 :controller => :person,   :action => :index,			:as => "listingPeople"	
	get "/people/new",						 :controller => :person,   :action => :new,				:as => "newUser"
	get "/people/connect",					 :controller => :person,	  :action => :connect, 			:as => "login"	
	post "/people/connect",					 :controller => :person,	  :action => :connect,			:as => "connect"
	post "/people", 						 :controller => :person,   :action => :create,			:as => "createUser"
	get "/people/:id/logout",				 :controller => :person,	  :action => :logout,			:as => "logout"

	get "posts/:id/comments/new",	 			 :controller => :comment,  :action => :new,				:as => "newComment"
	post "/posts/:id/comment",				 :controller => :comment,  :action => :create,			:as => "showComment"
	get "/posts/:id/comments/:comment_id", 		 :controller => :comment,  :action => :edit, 			:as => "editCom"
	put "/posts/:id/comments/:comment_id",		 :controller => :comment,  :action => :modify, 			:as => "modifyCom"	
	delete '/post/:id/comments/:comment_id',	 :controller => :comment,  :action => :destroy, 			:as => "deleteCom" 	

	post "/posts/:id/tag",					 :controller => :tag,     :action => :tagPost,			:as => "tagPost"
	post "/posts/:id/detag",					 :controller => :tag,     :action => :deTagPost,			:as => "deTagPost"
																		

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
