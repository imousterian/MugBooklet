Rails.application.routes.draw do

    devise_for :users, :path => "accounts", :controllers => {registrations: 'registrations'}
    root 'static_pages#home'
    match '/contact', to: "static_pages#contact", via: 'get'
    match '/sign_in_guest', to: "application#create_guest_user", via: 'get'

    scope ":name" do
        get '', to: 'users#show', as: 'name'
        # get '/edit', to: 'users#edit', as: 'user_name_edit'
    end

    resources :users do
        member do
            get :friends
        end
    end
    resources :friendships, only: [:create, :destroy, :update]
    resources :posts, only: [:create, :destroy, :edit]
    resources :comments
    resources :likes, only: [:create, :destroy]
    match '/likes/:id', to: "likes#selected_index", via: 'get', as: :showlikes

    # match '/add/:id', to: "comments#add", via: 'get', as: :add



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
