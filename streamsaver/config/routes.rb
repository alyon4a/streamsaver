Rails.application.routes.draw do
  get 'providers/new', to: 'providers#new', as: 'providers'
  get 'providers/create'
  get 'favorites/create'
  get 'favorites/index'
  get 'shows/new'
  get 'shows/create'
  get 'shows/index'
  get 'users/new'
  get 'users/create'
  get 'users/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
