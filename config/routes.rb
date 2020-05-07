Rails.application.routes.draw do
  get 'stripe_event/stripe_callback'
  get 'stripe_event/payment_profile'
  get 'stripe_event/payment_process'
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'contact#index'
  post '/contact/thanks',  to: 'contact#thanks'
  get  '/sell',    to: 'static_pages#sell'
  get  '/privacy_policy', to: 'static_pages#privacy_policy'
  get  '/service_term',    to: 'static_pages#service_term'

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
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end