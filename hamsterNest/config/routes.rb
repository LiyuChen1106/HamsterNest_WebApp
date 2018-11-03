Rails.application.routes.draw do

  # ROOT
  root "welcome#index"

  # Home page
  get "welcome", to: "welcome#index"

  # Pages
  get "/articles/:page", to: "application#show"

  # Resources
  resources :items
  resources :user_profiles, :path => "account/profiles"
  resources :histories
  resources :categories

  resources :items do
    collection { post :search, to: "items#index" }
  end

  #resources :borrow_requests

  resources :items do
    resources :borrow_requests
  end
  #resources :borrow_requests do
  #  resources :items
  #  resources :user_profiles
  #end
  #  devise_for :users, skip: [:sessions]
  #  devise_scope :user do
  #    get 'signin', to: 'devise/sessions#new', as: :new_user_session
  #    post 'signin', to: 'devise/sessions#create', as: :user_session
  #    delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
  #  end

  devise_for :users,
    :path => "account",
    :path_names => {
      :sign_in => "login",
      :sign_out => "logout",
      :password => "secret",
      :confirmation => "verification",
      :unlock => "unblock",
    }, skip: [:registration]
  devise_scope :user do
    get "/account/cancel", to: "devise/registrations#cancel", as: :cancel_user_registration
    get "/account/sign_up", to: "devise/registrations#new", as: :new_user_registration
    get "/account/edit", to: "devise/registrations#edit", as: :edit_user_registration
    post "/account", to: "devise/registrations#create", as: :user_registration
  end
end
