Rails.application.routes.draw do
  get 'about_pages/show'
  get 'contact_pages/show'
  # Devise routes for regular users
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }

  # Active Admin routes for admin users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Route for the admin dashboard
  authenticated :user, ->(u) { u.admin? } do
    root to: 'admin#index', as: :custom_admin_dashboard
    # Other routes for the custom-made index pages for admin can be added here.
  end

  # Route for the user dashboard
  authenticated :user, ->(u) { !u.admin? } do
    root to: 'users#index', as: :custom_user_dashboard
    # Other routes for the custom-made index pages for regular users can be added here.
  end

  unauthenticated do
    root to: 'devise/sessions#new'
  end

  # Other routes for your application can be added here.
  get '/contact', to: 'contact_pages#show'
get '/about', to: 'about_pages#show'
end
