Rails.application.routes.draw do

  devise_for :users, :controllers => {
  #:sessions      => "users/sessions",
  :registrations => "users/registrations",
  :passwords     => "users/passwords"
}

  root 'welcome#index'
  get   'vote_redo' , to: 'voterships#redo'
  get   'inquiry' , to: 'welcome#inquiry'
  post  'inquiry' , to: 'welcome#send_message'
  resources :voterships, only: [:create, :destroy]
  resources :users  do
    collection do
      get 'import_csv_new'
      post 'import_csv'
    end
  end
  resources :comments
  resources :tankas do
    member do
      get 'soul'
      get 'unsoul'
      get 'expose'
      get 'select'
    end
  end
  resources :dais do
    member do
      get 'vote'
      get 'proceed'
    end
    collection do
      get 'manage'
    end   
  end
  resources :issens

#http://easyramble.com/cutomize-controllers-on-rails-devise.html
  


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
