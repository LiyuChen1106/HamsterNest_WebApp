Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For test for Gmap
#  resources :gmap
  
  # ROOT
  root "welcome#index"

  # Home page
  get "welcome", to: "welcome#index"

  get "welcome/about"
  get "welcome/contact_us"
  get "welcome/terms_of_service"
  get "welcome/privacy_policy"
  get "welcome/faq"

  # Pages
  get "borrow_from_others", to: "user_profiles#borrow_from_others"

  # Resources
  resources :items
  resources :user_profiles, :path => "account/profiles"
  resources :categories

  get "lend_to_others", to: "user_profiles#lend_to_others"
  get "lend_rating", to: "user_profiles#lend_rating"
  get "borrow_rating", to: "user_profiles#borrow_rating"
  get "comment_history", to: "user_profiles#comment_history"
  resources :user_profiles do
    resources :items
  end

  resources :items do
    collection { post :search, to: "items#index" }
  end

  #resources :borrow_requests

  resources :items do
    resources :borrow_requests
  end
  
  resources :items do
    resources :comments
  end

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
