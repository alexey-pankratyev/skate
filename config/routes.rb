Myndozero::Application.routes.draw do

  # get "password_resets/new"

  # get "direct_messages/new"

  #get "sessions/new"
  #get "pages/new"
  #get "users/new"
  
  root :to => 'pages#home'
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :pages
  
  resources :direct_messages , only: [] do
    get :received, on:  :collection
    get :sent, on: :collection
  end
  # match '/sent_direct_messages',  :to => 'direct_messages#sent'
  
  
    match '/contact', :to => 'pages#contact'
    match '/about',   :to => 'pages#about'
    match '/help',    :to => 'pages#help'
    match '/email',   :to => 'pages#email'
    match '/reviews', :to => 'pages#reviews'
 
  resources :users
    
    match '/signup', :to => 'users#new'

  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :sessions, :only => [:new, :create, :destroy]
  
    match '/signin',  :to => 'sessions#new'
    match '/signout', :to => 'sessions#destroy', via: :delete
  
  resources :password_resets
    
  

  #map.connect ':controller.:format'
  #map.connect ':controller/:action/:id.:format'
 
   # The priority is based upon order of creation:
  # first created -> highest priority.

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
  # match ':controller(/:action(/:id))(.:format)'
end
