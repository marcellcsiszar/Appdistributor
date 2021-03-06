Appdistributor::Application.routes.draw do
  get "download/package/:id", to:'download#package'
  devise_for :users, :controllers => { :sessions => "sessions", :registrations => "registrations" }
  resources :users do
    resources :organizations
  end
  resources :dashboard do
    resource :user
  end
  resources :customers do
    resources :users
  end
  resources :projects do
    resources :customers
    resources :ipaapps, controller: 'ipaapps', :except => [:index] do
      resources :ipabuilds, only: [:new, :create] do
        resources :notifications, only: [:new, :create, :index]
      end
    end
    resources :apkapps, controller: 'apkapps', :except => [:index] do
      resources :apkbuilds, only: [:new, :create] do
        resources :notifications, only: [:new, :create, :index]
      end
    end
    resource :organization
  end
  resources :organizations do
    resources :users
    resources :projects
  end

  get '/welcome', to: 'user/dashboard#welcome'
  get '/welcome/add', to: 'user/dashboard#add'

  use_doorkeeper

  authenticated :user do
    root :to => "user/dashboard#index", :as => "authenticated_user_root"
    # Rails 4 users must specify the 'as' option to give it a unique name
    # root :to => "main#dashboard", :as => "authenticated_root"
  end

  authenticated :admin do
    root :to => "admin/dashboard#index", :as => "authenticated_admin_root"
    # Rails 4 users must specify the 'as' option to give it a unique name
    # root :to => "main#dashboard", :as => "authenticated_root"
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'user/dashboard#index'

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
