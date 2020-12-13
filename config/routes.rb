Rails.application.routes.draw do
  resources :collections
  resources :movie_actors
  resources :actors
  resources :movies
  resources :directors
  resources :users

  
  root 'users#home'
  get '/auth/:provider/callback', to: 'users#omniauth'
  get 'auth/failure', to: redirect('/')
  get '/users/login', to: 'users#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
