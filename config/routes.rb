Rails.application.routes.draw do
  post 'home', to: 'home#update'
  get 'home/index'
  root 'home#index'

  resources :students
  resources :places
  resources :bands
end
