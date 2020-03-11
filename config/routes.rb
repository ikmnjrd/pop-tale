Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :paintings,          only: [:create, :destroy, :show]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  #知識不足のため暫定的なルーティング。簡単なところでrootes.rb内での記述の順番とか間違えるとえらいことになる。バグの元。
  get "/:id", to: "static_pages#home" 
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end