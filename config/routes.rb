Rails.application.routes.draw do
  devise_for :users
  resources :households
  root 'households#index'
end
