Rails.application.routes.draw do
  devise_for :users
  resources :households do
    resources :bills
  end
  root 'households#index'
end
