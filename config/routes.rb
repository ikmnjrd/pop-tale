Rails.application.routes.draw do
  get 'stripe_event/stripe_callback'
  get 'stripe_event/payment_profile'
  get 'stripe_event/payment_process'
  #post 'stripe_event/payment_process'
  #post "paintings/:id", to: "stripe_event#payment_process", as: "charge_test"
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/sell',    to: 'static_pages#sell'
  #get  '/signup',  to: 'users#new'
  #post '/signup',  to: 'users#create'
  #get    '/login',   to: 'sessions#new'
  #post   '/login',   to: 'sessions#create'
  #delete '/logout',  to: 'sessions#destroy'
  resources :users, only: [:index, :show]
  namespace :paintings do
    get :admin
    post :admin_update
  end
  resources :paintings,          except: [:new, :index] do
    collection do
      get 'search'
    end
  end
  resource :mypages,    only: [:show]
  namespace :mypages do
    get :purchases
    get :sold
    get :connect_stripe
  end
  #resources :account_activations, only: [:edit]
  #resources :password_resets,     only: [:new, :create, :edit, :update]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end