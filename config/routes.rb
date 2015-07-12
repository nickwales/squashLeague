SquashLeague::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :rankings, :only => [:index, :show]

#  get "players/show"

  resources :results

  resources :matches

  resources :playerdivs

  resources :seasons

  resources :divisions

  devise_for :players
  resources :players, :only => [:show, :index]

  resources :blogs
  
  #resources :pages
  get '/rules', :to => 'pages#rules'
  get '/tables', :to => 'pages#table'
  get '/contact', :to => 'pages#contact'
  get '/about',   :to => 'pages#about'
  get '/help',    :to => 'pages#help'
# match '/signup',  :to => 'users#new'
#  match '/signin',	:to => 'sessions#new'
  get '/signout', :to => 'sessions#destroy'
  get '/league',  :to => 'pages#league'
  get '/results', :to => 'pages#results'
  get '/rank', :to => 'pages#rankings'
  get '/about',    :to => 'pages#about'
#  match '/league/gold',  :to => 'pages#league?page=2'
  get '/emails', :to => 'pages#emails'
  
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
  root :to => 'blogs#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
