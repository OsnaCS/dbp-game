Rails.application.routes.draw do
  resources :newsfeeds

  resources :unit_instances do
    member do
      get 'cancel_build'
      get 'instant_build'
      get 'build'
    end
  end

  resources :units
  resources :build_lists

  resources :facility_instances do
    member do
      get 'build'
      get 'cancel_build'
      get 'instant_build'
    end
  end

  resources :expedition_instances

  get 'notification_view/index'
  resources :damage_types
  resources :fighting_fleets do
    resources :ship_groups
    resources :fights
  end

  resources :science_instances do
    member do
      get 'research'
      get 'cancel_research'
      get 'instant_research'
    end
  end

  resources :ships do
    member do
      get 'cheat'
    end
    resources :ships_stations
  end

  resources :ships_stations do
    member do
      get 'upgrade'
      get 'cancel_upgrade'
      get 'instant_upgrade'
      get 'downgrade'
    end
  end

  resources :user_ships
  resources :notifications
  resources :messages
  resources :stations
  resources :sciences
  resources :facilities
  resources :expeditions
  resources :ranks
  resources :user_icons
  resources :ships
  resources :ships_station

  resources :trades do
    member do
      get 'buy'
    end
  end

  get 'home/index'
  get 'home/get_json_data', defaults: {format: 'json'}
  get 'profile/index'
  get 'profile/user'
  get 'profile/:username', to: 'profile#user', as: 'profile'
  get 'home/index'

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'newsfeeds#index'
    end
    unauthenticated :user do
      root :to => 'newsfeeds#index', as: :unauthenticated_root
    end
  end

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
