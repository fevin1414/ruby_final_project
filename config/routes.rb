Rails.application.routes.draw do

  #payment routes
  scope '/payment' do
    post 'create', to: 'payment#create', as:'payment_create'
    get 'cancel', to: 'payment#cancel', as:'payment_cancel'
    get 'success', to: 'payment#success', as: 'payment_success'
    get 'redirect_action', to: 'payment#redirect_action', as:'payment_redirect'
  end
  post 'checkout/stripe_payment', to: 'checkout#stripe_payment', as: 'stripe_payment_checkout'

  get 'carts/show'

  # Checkout routes
  get 'checkout/index', to: 'checkout#index', as: 'index_checkout'
  post 'checkout', to: 'checkout#create'
  get 'checkout/invoice', to: 'checkout#invoice', as: 'invoice_checkout'
  get 'checkout/payment_success', to: 'checkout#payment_success', as: 'checkout_payment_success'

  root 'application#choose_root_path' # Change the root route to point to choose_root_path

  resources :products, only: [:index, :show] do
    member do
      get :view_in_3d
    end
  end
  mount StripeEvent::Engine, at: '/stripe/webhooks'
 # config/routes.rb
post '/stripe_webhooks', to: 'stripe_webhooks#create'
get 'payment_success', to: 'checkout#payment_success'


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

  resources :users, only: [:show]

  # Add the custom route for users#index
  get 'users', to: 'users#index', as: 'users'
end
