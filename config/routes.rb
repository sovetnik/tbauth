Rails.application.routes.draw do

  root to: 'users#index'

  get 'token', to: 'grants#token'
  get 'grants/welcome'

  resources :user_sessions, only: [:create]
  resources :users

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
  
  get 'profile' => 'users#profile', :as => :profile

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
