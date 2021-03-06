Rails.application.routes.draw do

  root 'welcome#index'
  get '/about' => 'welcome#about'
  get 'search_results' => 'search#show_posts'
  get 'connection_results' => 'search#show_users'
  get 'clear' => 'search#clear'

  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks", 
    :registrations => "users/registrations"
  }
  resources :users, :only => [:show, :update, :edit]

  resource :institutions, :only => [:create]#, :as => "institutions"
  
  resources :user_institutions, :only => [:create, :edit, :update, :destroy]
  resources :resources, :only => [:index, :show]
  resources :connections, only: [:index, :create, :update]
  # resources :goals, :only => [:show]
  get 'goals/:name' => 'goals#show', :as => 'goal'
  resources :locations, only: [:index, :show]

  # resources :posts, :only => [:index, :show]
  get 'forum' => 'posts#index', :as => 'posts'
  post 'forum' => 'posts#create'
  get 'forum/new' => 'posts#new', :as => 'new_post'
  get 'forum/:id/edit' => 'posts#edit', :as => 'edit_post'
  get 'forum/:id' => 'posts#show', :as => 'post'
  patch 'forum/:id' => 'posts#update'
  delete 'forum/:id' => 'posts#destroy'

  
  # NOTES ON PROFILES & AUTHOR/AUTHENTICATION
    # get '/[:user_id]' => 'profile#show' #has no authorization at all (right now), unless you want to specify that a user is LOGGED IN before they can send a message. (authentication, but not authorization.)
  
    # # will need to POST a profile PATCH page
    # #post/patch '/[:user_id]' => 'profile#update'
    # get '/my_profile/settings' => 'users#settings'

    # should profile and settings be one and the same?

  # RAILS EXAMPLES 

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
