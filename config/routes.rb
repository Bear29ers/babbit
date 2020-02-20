Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/terms', to: 'static_pages#terms'
  get '/policy', to: 'static_pages#policy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/newpost', to: 'posts#new'
  post '/newpost', to: 'posts#create'

  get '/contact', to: 'contacts#new'
  post '/contact', to: 'contacts#create'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :posts
  resources :contacts, only: [:new, :create]
end