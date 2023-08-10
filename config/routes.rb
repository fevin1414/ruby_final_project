Rails.application.routes.draw do
  get 'checkout/index'
  get 'checkout/create'
  get 'carts/show'

  get 'checkout/address', to: 'checkout#address'
  post 'checkout/create_address', to: 'checkout#create_address'
  patch 'checkout/update_address/:id', to: 'checkout#update_address', as: 'update_address'
  get 'checkout/invoice', to: 'checkout#invoice' # Add this line to handle the invoice view
  post 'checkout/pay_now', to: 'checkout#pay_now', as: 'pay_now_checkout'


  resources :guest_checkout, only: [] do
    collection do
      get 'new_address'
      post 'create_address', as: 'create_address'
      get 'invoice', to: 'guest_checkout#invoice', as: 'invoice' # <-- Fixed this line
    end
  end


  root 'application#choose_root_path' # Change the root route to point to choose_root_path

  resources :products, only: [:index, :show] do
    member do
      get :view_in_3d
    end
  end

  resources :categories, only: [:show]
  resource :cart, only: [:show] do
    post 'add_item'
    post 'remove_item'
    post 'update_item'
  end

  get 'about_pages/show'
  get 'user_dashboard', to: 'users#dashboard', as: 'user_dashboard'

  get 'contact_pages/show'
  resources :addresses, only: [:index, :new, :create, :edit, :update, :destroy]




  devise_for :users, path: 'users', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }
  # Active Admin routes for admin users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Other routes for your application can be added here.
  get '/contact', to: 'contact_pages#show'
  get '/about', to: 'about_pages#show'
  get 'checkout', to: 'checkout#index'
  post 'checkout', to: 'checkout#create'

  resources :users, only: [:show]

  # Add the custom route for users#index
  get 'users', to: 'users#index', as: 'users'
end