Rails.application.routes.draw do
  root 'students#index'

  resources :students
  resources :places
  resources :bands
end
