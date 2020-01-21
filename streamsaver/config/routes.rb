Rails.application.routes.draw do
  get 'providers/new', to: 'providers#new', as: 'new_provider'
  # post 'providers', to: 'providers#create', as: 'providers'
  # get 'shows/new', to: 'shows#new', as: 'new_show'
  # get 'shows/create', to: 'shows#create', as: 'create_show'
  # get 'shows', to: 'shows#index', as: 'shows'
  get '/welcome', to: 'users#login', as: "welcome"
  get 'users/new', to: 'users#new', as: 'new_user'
  post 'users', to: 'users#create'
  get 'users/:id', to: 'users#show', as: 'user_dashboard'
  # post 'users/:id/favorites/create', as: 'new_favorite'
  # get 'users/:id/favorites/plan', to: 'favorites#plan', as: 'user_plan' #indicate which months you want to watch each show
  # post 'users/:id/favorites', to: 'favorites', as: 'create_plan'
  

end
