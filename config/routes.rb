Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [:index, :show]

  get 'about_pages/show'
  get 'contact_pages/show'

  # Devise routes for regular users
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }

  # Active Admin routes for admin users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Other routes for your application can be added here.
  get '/contact', to: 'contact_pages#show'
  get '/about', to: 'about_pages#show'
end
