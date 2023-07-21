Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }

  devise_scope :user do
    authenticated :user, ->(u) { u.admin? } do
      root to: 'admin#index', as: :admin_root
    end

    authenticated :user, ->(u) { !u.admin? } do
      root to: 'users#index', as: :user_root
    end

    unauthenticated do
      root to: 'devise/sessions#new'
    end
  end

  # Other routes for the custom-made index pages for admin and user can be added here.
end
