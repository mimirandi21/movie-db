Rails.application.routes.draw do
  root 'users#home'
  get '/auth/:provider/callback', to: 'users#omniauth'
  get 'auth/failure', to: redirect('/')
  get '/users/login', to: 'users#login'
  get 'users/movies/choose', to: 'movies#choose'
  
  resources :movie_directors
  resources :user_movies do
    resources :movies
  end
  resources :movie_actors
  resources :actors do 
    resources :movies, only: [:show]
  end
  resources :movies
  resources :directors do
    resources :movies, only: [:show]
  end
  resources :users do
    resources :movies
    resources :user_movies
    resources :actors, only: [:show, :index]
    resources :directors, only: [:show, :index]
  end


  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
