Rails.application.routes.draw do
  
  # ROOT
  root 'welcome#index'
  
  # Home page
  get 'welcome', to: 'welcome#index'
  
  # Pages
  get '/articles/:page', to: 'application#show'
  
  # Resources
  resources :items
  resources :user_details
  resources :user_accounts
  resources :histories
  resources :categories
  

end
