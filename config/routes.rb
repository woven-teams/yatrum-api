Rails.application.routes.draw do
  # get 'users/create'

  resources :trips
  get 'users/:user_id/trips', to: 'trips#get_user_trips'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'authenticate', to: 'authentication#authenticate'
  post 'users/create', to: 'users#create'
  post 'users/show', to: 'users#show'
end
