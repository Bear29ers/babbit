Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/terms', to: 'static_pages#terms'
  get '/policy', to: 'static_pages#policy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users
end
