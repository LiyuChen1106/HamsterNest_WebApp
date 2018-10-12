Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items
  resources :user_details
  resources :users
  resources :histories
  resources :categories


end
