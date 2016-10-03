Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'

  resources :students
  resources :places
  resources :bands
end
