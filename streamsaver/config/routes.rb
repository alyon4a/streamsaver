Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'providers/new', to: 'providers#new', as: 'new_provider'
  # post 'providers', to: 'providers#create', as: 'providers'
  # get 'shows/new', to: 'shows#new', as: 'new_show'
  # get 'shows/create', to: 'shows#create', as: 'create_show'
  # get 'shows', to: 'shows#index', as: 'shows'
  get 'shows/new', to: 'shows#new', as: 'new_show'
  get 'shows/create', to: 'shows#create', as: 'create_show'
  get 'shows', to: 'shows#index', as: 'shows'

  post '/signup', to: 'users#create'
  get '/signup', to: 'users#new', as: 'users'

  get '/favorites', to: "favorites#index", as: "favorites"

  get 'users/:id', to: 'users#show', as: 'user_dashboard'
  #post 'users/:id/favorites/create', as: 'new_favorite'
  get 'users/:id/favorites/new_plan', to: 'favorites#plan', as: 'user_plan' #indicate which months you want to watch each show
  post 'users/:id/favorites', to: 'favorites#create', as: 'create_plan'

  #session routes

  get "/login", to: 'sessions#new', as: 'login'
  post "/login", to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

end
