Rails.application.routes.draw do
  root 'users#home'
  get '/auth/:provider/callback', to: 'users#omniauth'
  get 'auth/failure', to: redirect('/')
  get '/users/signin', to: 'users#signin'
  post '/users/signin', to: 'users#login'
  get '/user/logout', to: 'users#logout'
  get 'users/:user_id/movies/choose', to: 'movies#choose', as: :choose
  get 'users/:user_id/movies/apichoose', to: 'movies#apichoose', as: :apichoose
  get 'users/:user_id/movies/find', to: 'movies#find', as: :find
  post 'users/:user_id/movies/find', to: 'movies#create'
  post 'users/:user_id/movies/choose', to: 'movies#create_from_db', as: :dbcreate
  post 'users/:user_id/movies/apichoose', to: 'api#create_from_api', as: :apicreate

  
  resources :genres do
    resources :movies, only: [:index]
  end
  resources :years
  resources :ratings
  resources :scores
  resources :writers do
    resources :movies, only: [:index]
  end
  resources :user_movies do
    resources :movies
  end
  resources :actors do 
    resources :movies, only: [:index]
  end
  resources :movies
  resources :directors do
    resources :movies, only: [:index]
  end
  resources :users do
    resources :movies, :as => :collection
    resources :user_movies
    resources :actors, only: [:index]
    resources :directors, only: [:index]
    resources :years, only: [:index]
    resources :genres, only: [:index]
    resources :rating, only: [:index]
    resources :score, only: [:index]
    resources :writers, only: [:index]
  end


  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
