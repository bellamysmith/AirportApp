Coffeereview::Application.routes.draw do

  root 'airports#index'

  resources :airports

  get 'airports/new' => 'airports#new', as: :add_airport
 



  resources :users
  get 'users/:id/reviews' => 'users#review_list', as: :user_reviews
  delete 'users/:id/edit' => 'users#destroy', as: :delete_user
  get '/signup' => 'users#new', as: :sign_up

  get '/signin', to: 'sessions#new', as: :sessions
  post '/signin', to: 'sessions#create', as: :sign_in
  delete '/signout' => 'sessions#destroy', as: :sign_out


  

  resources :flights
  post '/flights' => 'flights#create'


 

  resources :reviews
  get 'reviews/new' => 'reviews#new', as: :add_review
 


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
