Rails.application.routes.draw do
  
  # providers
  get 'providers/new', to: 'providers#new', as: 'new_provider'
  # post 'providers', to: 'providers#create', as: 'providers'

  # shows
  get 'shows/new', to: 'shows#new', as: 'new_show'
  post 'shows', to: 'shows#create', as: 'create_show'
  get 'shows', to: 'shows#index', as: 'shows'

  # user login-signup
  post '/signup', to: 'users#create'
  get '/signup', to: 'users#new', as: 'users'

  get '/dashboard', to: 'users#show', as: 'user_dashboard'
  
  #session routes

  get "/login", to: 'sessions#new', as: 'login'
  post "/login", to: 'sessions#create'
  post "/logout", to: 'sessions#destroy', as: 'logout'

  # TBD
  #get '/favorites', to: "favorites#index", as: "favorites"



  #favorite routes
  get '/plan', to: 'favorites#new', as: 'plan'
  post '/plan', to: 'favorites#create'
  post '/create_plan', to: 'favorites#create_plan'

end
