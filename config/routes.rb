Rails.application.routes.draw do
  devise_for :users
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
  end
  #resources :account_activations, only: [:edit]
  #resources :password_resets,     only: [:new, :create, :edit, :update]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end