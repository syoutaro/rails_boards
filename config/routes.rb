Rails.application.routes.draw do
  devise_for :users
  root 'boards#index'
  resources :boards
  resources :comments, only: %i[create destroy]
  resources :tags, only: %i[new create]
end
