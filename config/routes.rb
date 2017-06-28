Rails.application.routes.draw do

  root "sessions#index"

  resources :attractions
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get '/signin', to: "sessions#new"
end