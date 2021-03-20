Rails.application.routes.draw do
  root to: 'operations#index'

  post :signup, to: 'users#create'
  post :login, to: 'sessions#create'

  resources :operations, only: %i[index create]
end
