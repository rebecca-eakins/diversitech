Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :users, :only => [:show, :update, :edit]
  # resources :users, :controllers => { :profiles => "users/profiles" }
  # resources :'users/profiles'

  resources :user_institutions, :only => [:create, :edit, :update, :destroy]
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'search_results' => 'search#show'
  
  # get '/[:user_id]' => 'profile#show' #has no authorization at all (right now), unless you want to specify that a user is LOGGED IN before they can send a message. (authentication, but not authorization.)

  # get '/[:user_id]/edit' => 'profile#edit' #this will require authorization so that the current user can only see the edit page for their user ID or slug.
  
  # # will need to POST a profile PATCH page
  # #post/patch '/[:user_id]' => 'profile#update'
  # get '/my_profile/settings' => 'users#settings'

  #should profile and settings be one and the same?


  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :resources, :only => [:index, :show]

  resources :goals, :only => [:show] do
    resources :posts, :only => [:index, :show]
  end

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
